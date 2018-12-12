require 'teracy-dev/config/configurator'
require 'teracy-dev/plugin'
require 'teracy-dev/util'

module TeracyDevV05Compat
  module Config
    class GatlingRsyncRecovery < TeracyDev::Config::Configurator

      def configure_node(settings, config)
        # The trigger is only supported by vagrant version >= 2.2.0
        require_version = ">= 2.2.0"
        vagrant_version = Vagrant::VERSION

        if !TeracyDev::Util.require_version_valid?(vagrant_version, require_version)
          @logger.warn("vagrant's current version: #{vagrant_version}")
          @logger.warn("The trigger is only supported by vagrant version `#{require_version}`")
          return
        end

        synced_folders_settings = settings['vm']['synced_folders'] || []
        return if synced_folders_settings.empty?

        rsync_exists = synced_folders_settings.find { |x| x['type'] == 'rsync' }

        return if rsync_exists.nil?

        return if !gatling_rsync_installed? # or unless gatling_rsync?

        # To Ensure gatling-rsync don't run on start up
        config.gatling.rsync_on_startup = false

        config.trigger.after :up, :reload, :resume do |trigger|
          trigger.ruby do |env,machine|
            begin
              system("vagrant gatling-rsync-auto")
              raise unless $?.exitstatus == 0
            rescue
              @logger.info('rsync crashed, retrying...')
              retry
            end

          end
        end
      end

      private

      def gatling_rsync_installed?
        return TeracyDev::Plugin.installed?('vagrant-gatling-rsync')
      end

    end
  end
end
