require File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper')

describe Truth::Entity::Dsl::Template do
  before :each do
    @config = new_configuration
  end

  it "templatizes things" do
    sensor = mock(:hit => true)
    sensor.should_receive(:hit).with(an_instance_of(Truth::Host))

    @config.dsl_eval do
      templates {
        # a typical host will have eth0
        host(:with_eth0) {
          interface :eth0
          sensor.hit(@target)
        }
      }

      host('u11r1.xxx') {
        template :with_eth0
      }
    end

  end

  it "automatically applies the default template" do
    sensor = mock(:hit => true)
    sensor.should_receive(:hit).with(an_instance_of(Truth::Host))

    @config.dsl_eval do
      templates {
        host(:default) {
          sensor.hit(@target)
        }
      }

      host 'u22r2.yyy'
    end
  end
end
