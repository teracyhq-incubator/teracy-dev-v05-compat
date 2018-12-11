require 'teracy-dev'

require_relative 'teracy-dev-v05-compat/config/gatling_rsync_recovery'
require_relative 'teracy-dev-v05-compat/processors/multiple_essential_support'
module TeracyDevV05Compat

  def self.init
    TeracyDev.register_processor(Processors::MultipleEssentialSupport.new)
    TeracyDev.register_configurator(TeracyDevV05Compat::Config::GatlingRsyncRecovery.new)
  end

end
