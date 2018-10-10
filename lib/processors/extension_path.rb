require 'teracy-dev/processors/processor'
require 'teracy-dev/util'

module TeracyDevV05Compat
  module Processors
    # variables processor
    class ExtensionPath < TeracyDev::Processors::Processor

      def process(settings)
        settings['default']['provisioners'].each do |provisioner|
          type = provisioner['type']

          if type == 'chef_solo'
            if !provisioner['cookbooks_path'].nil?
              provisioner['cookbooks_path'].each_index { |i|
                extension_relative_paths = provisioner['cookbooks_path'][i].split(File::SEPARATOR)
                extension_base_path = TeracyDev::Util.extension_lookup_path(settings, extension_relative_paths[0])
                @logger.debug("extension base path for #{extension_relative_paths[0]} is #{extension_base_path}")
                provisioner['cookbooks_path'][i] = "#{extension_base_path}/#{provisioner['cookbooks_path'][i]}"

              }
            end
            if !provisioner['roles_path'].nil?
                extension_relative_paths = provisioner['roles_path'].split(File::SEPARATOR)
                extension_base_path = TeracyDev::Util.extension_lookup_path(settings, extension_relative_paths[0])
                provisioner['roles_path'] = "#{extension_base_path}/#{provisioner['roles_path']}"
            end

            if !provisioner['nodes_path'].nil?
                extension_relative_paths = provisioner['nodes_path'].split(File::SEPARATOR)
                extension_base_path = TeracyDev::Util.extension_lookup_path(settings, extension_relative_paths[0])
                provisioner['nodes_path'] = "#{extension_base_path}/#{provisioner['nodes_path']}"
            end

            if !provisioner['data_bags_path'].nil?
                extension_relative_paths = provisioner['data_bags_path'].split(File::SEPARATOR)
                extension_base_path = TeracyDev::Util.extension_lookup_path(settings, extension_relative_paths[0])
                provisioner['data_bags_path'] = "#{extension_base_path}/#{provisioner['data_bags_path']}"
            end
            provisioner['log_level'] = ENV['LOG_LEVEL'] ||= "info"
          end
        end if settings['default'] && settings['default']['provisioners']

        @logger.debug("processed settings: #{settings}")

        settings
      end
    end
  end
end
