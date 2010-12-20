require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Truth::Host do
  before :each do
    @config = new_configuration
  end

  it "creates with dsl and no block" do
    @config.dsl_eval do
      host :foo
    end

    @config.hosts.should have_key :foo
    @config.host(:foo).should be_a Truth::Host
  end

  it "creates with dsl and a block" do
    @config.dsl_eval do
      host(:foo) {
        loc 'u31r2.dc1'
      }
    end

    @config.hosts.should have_key :foo
    @config.host(:foo).should be_a Truth::Host

    host = @config.hosts[:foo]
    host.name.should == :foo
    host.loc.should == 'u31r2.dc1'
    host.rack_unit.should == 31
    host.rack.should == 2
    host.datacenter.should be_a Truth::Datacenter
    host.datacenter.name.should == :dc1
  end

  it "delegates to an interface" do
    @config.dsl_eval do
      host(:foo) {
        interface(:eth0) {
          mac '01:12:23:34:45:56'
        }
      }
    end

    @config.hosts.should have_key :foo
    @config.host(:foo).should be_a Truth::Host

    host = @config.hosts[:foo]
    host.interfaces.should have_key :eth0
    host.interface(:eth0).should be_a Truth::Interface
    host.interface(:eth0).mac.should == '01:12:23:34:45:56'
  end
end
