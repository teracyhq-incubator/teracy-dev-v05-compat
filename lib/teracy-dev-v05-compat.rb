require 'teracy-dev'
require_relative 'processors/extension_path'

module TeracyDevV05Compat

  def self.init
    TeracyDev.register_processor(TeracyDevV05Compat::Processors::ExtensionPath.new)
  end

end
