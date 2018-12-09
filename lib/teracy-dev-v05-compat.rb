require 'teracy-dev'

require_relative 'teracy-dev-v05-compat/trigger/rsync_trigger'

module TeracyDevV05Compat

  def self.init
    TeracyDev.register_configurator(TeracyDevV05Compat::Trigger::RsyncTrigger.new)
  end

end
