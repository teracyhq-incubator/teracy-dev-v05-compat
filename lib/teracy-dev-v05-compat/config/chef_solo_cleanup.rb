require 'fileutils'

require 'teracy-dev/config/configurator'


module TeracyDevV05Compat
  module Config
    class ChefSoloCleanup < TeracyDev::Config::Configurator

      def configure_common(settings, config)

        @last_node = settings['nodes'].last['name']

      end

      def configure_node(settings, config)
        return if settings['name'] != @last_node
        @host_name = settings['vm']['hostname']
        configure_trigger_before(config)
      end

      private

      def configure_trigger_before(config)
        config.trigger.before :up, :reload do |trigger|
          trigger.ruby do |env, machine|
            v05_compat_ext_path = File.join(TeracyDev::BASE_DIR,
              TeracyDev::DEFAULT_EXTENSION_LOOKUP_PATH, 'teracy-dev-v05-compat')
            json_node_file = File.join(v05_compat_ext_path, 'provisioners', 'chef_solo', 'nodes', "#{@host_name}.json")
            if File.file? json_node_file
              @logger.info("Deleting existing file to avoid cache problem: #{json_node_file}")
              FileUtils.remove_file(json_node_file)
            end
          end
        end
      end
    end
  end
end
