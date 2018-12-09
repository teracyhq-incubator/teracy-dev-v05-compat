require 'teracy-dev/config/configurator'
require 'teracy-dev/plugin'
require 'teracy-dev/util'

module TeracyDevV05Compat
  module Trigger
    class RsyncTrigger < TeracyDev::Config::Configurator

      def configure_node(settings, config)
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
              puts 'rsync crashed, retrying...'
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
