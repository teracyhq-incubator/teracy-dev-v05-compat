require 'teracy-dev'

require_relative 'teracy-dev-v05-compat/processors/multiple_essential_support'
require_relative 'teracy-dev-v05-compat/processors/provisioner_id_deprecated_removal'

module TeracyDevV05Compat

  def self.init
    TeracyDev.register_processor(Processors::MultipleEssentialSupport.new)
    TeracyDev.register_processor(Processors::ProvisionerIdDeprecatedRemoval.new)
  end

end
