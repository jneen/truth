require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Truth::Interface do
  before :each do
    @config = new_configuration
  end

  it "can be constructed with dsl" do
    @config.dsl_eval do
      host('u1r1.dc') {
        interface :eth0
      }
    end

    @config.host('u1r1.dc').interfaces.should have_key :eth0
    @config.host('u1r1.dc').interfaces[:eth0].should be_a Truth::Interface
  end

  it "has a mac and an address" do
    @config.dsl_eval do
      host('u1r1.dc') {
        interface(:eth1) {
          mac 'AA:AA:AA:AA:AA:AA'
          address '1.1.1.1'
        }
      }
    end

    @config.host('u1r1.dc').interfaces.should have_key :eth1
    @config.host('u1r1.dc').interfaces[:eth1].should be_a Truth::Interface

    eth1 = @config.host('u1r1.dc').interface(:eth1)
    eth1.mac.should == 'aa:aa:aa:aa:aa:aa'
    eth1.address.should be_a IP
    eth1.address.to_s.should == '1.1.1.1'
  end
end
