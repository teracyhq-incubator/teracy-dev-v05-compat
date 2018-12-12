require 'teracy-dev/processors/processor'

module TeracyDevV05Compat
  module Processors
    # a workaround to fix the following problem:
    # $ vagrant up
    # Bringing machine 'teracy-dev.local' up with 'virtualbox' provider...
    # There are errors in the configuration of this machine. Please fix
    # the following errors and try again:
    # chef solo provisioner:
    # * The following settings shouldn't exist: _id_deprecated
    #
    # @see: https://github.com/teracyhq-incubator/teracy-dev-core/issues/58
    class ProvisionerIdDeprecatedRemoval < TeracyDev::Processors::Processor

      def process(settings)
        settings['nodes'].each_with_index do |node, node_idx|
          node['provisioners'].each_with_index do |provisioner, idx|
            if !provisioner['_id_deprecated'].nil?
              provisioner.delete('_id_deprecated')
              node['provisioners'][idx] = provisioner
              settings['nodes'][node_idx] = node
            end
          end unless node['provisioners'].nil?
        end unless settings['nodes'].nil?
        return settings
      end
    end
  end
end
