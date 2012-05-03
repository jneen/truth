describe Truth::Host do
  before :each do
    @config = new_configuration
  end

  it "creates with dsl and no block" do
    @config.dsl_eval do
      host 'u21r3.dc1'
    end

    @config.hosts.should have_key 'u21r3.dc1'
    @config.host('u21r3.dc1').should be_a Truth::Host
  end

  it "creates with dsl and a block" do
    @config.dsl_eval do
      host('u21r3.dc1') {
        name :foo
      }
    end

    @config.hosts.should have_key 'u21r3.dc1'
    @config.host('u21r3.dc1').should be_a Truth::Host

    host = @config.hosts['u21r3.dc1']
    host.name.should == :foo
    host.loc.should == 'u21r3.dc1'
    host.rack_unit.should == 21
    host.rack.should == 3
    host.datacenter.should be_a Truth::Datacenter
    host.datacenter.name.should == :dc1
  end

  it "delegates to an interface" do
    @config.dsl_eval do
      host('u21r4.dc2') {
        interface(:eth0) {
          mac '01:12:23:34:45:56'
        }
      }
    end

    @config.hosts.should have_key 'u21r4.dc2'
    @config.host('u21r4.dc2').should be_a Truth::Host

    host = @config.hosts['u21r4.dc2']
    host.interfaces.should have_key :eth0
    host.interface(:eth0).should be_a Truth::Interface
    host.interface(:eth0).mac.should == '01:12:23:34:45:56'
  end
end
