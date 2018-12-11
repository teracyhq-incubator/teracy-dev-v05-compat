require 'teracy-dev/processors/processor'
require 'teracy-dev/extension/manager'
require 'teracy-dev/util'

module TeracyDevV05Compat
  module Processors
    # support multiple essential versions (to keep backward compatibility)
    class MultipleEssentialSupport < TeracyDev::Processors::Processor

      def process(settings)
        # @logger.debug("settings: #{settings}")
        plugins = settings['vagrant']['plugins']
        @logger.debug("plugins: #{plugins}")
        # default: _id: essential-hostmanger (works with >= 0.2.0)
        # if essential <= 0.1.0 => update the _id: essential-0 instead
        essential_version = extension_version(settings, 'teracy-dev-essential')
        if Gem::Requirement.new('<= 0.1.0').satisfied_by?(Gem::Version.new(essential_version))
          @logger.debug("need to support the old teracy-dev-essential version: #{essential_version}")

          essential_override_conf = plugins.find { |item| item['_id'] == 'essential-hostmanager' }

          if !essential_override_conf.nil?
            # remove the new incompatible plugin config
            plugins.each do |plugin|
              if plugin['_id'] == 'essential-hostmanager'
                plugins.delete(plugin)
              end
            end
            # reset _id
            essential_override_conf['_id'] = 'essential-0'
            # override dynamically
            plugins.each_with_index do |plugin, idx|
              if plugin['_id'] == 'essential-0'
                plugin = TeracyDev::Util.override(plugin, essential_override_conf)
                plugins[idx] = plugin
              end
            end
          end
        end
        @logger.debug("plugins: #{plugins}")
        settings['plugins'] = plugins
        return settings
      end

      private

      # get installed extension version by looking up its name
      def extension_version(settings, extension_name)
        extensions = settings['teracy-dev']['extensions'] || []

        extensions.each do |ext|
          manifest = TeracyDev::Extension::Manager.manifest(ext)
          if manifest['name'] == extension_name
            return manifest['version']
          end
        end
        # extension_name not found
        return nil
      end
    end
  end
end
