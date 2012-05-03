describe Truth::Network do
  before :each do
    @config = new_configuration
  end

  it "creates with dsl and no block" do
    @config.dsl_eval do
      network '10.0.1.0/24'
    end

    @config.networks.should have_key '10.0.1.0/24'
    @config.network('10.0.1.0/24').should be_a Truth::Network
  end

  it "creates with dsl and a block" do
    @config.dsl_eval do
      host('u1r1.dc') {
        name :ns1
      }

      host('u1r1.dc') {
        name :ns2
      }

      network('10.10.0.0/20') {
        #name_server :ns1
      }
    end

    @config.networks.should have_key '10.10.0.0/20'
    @config.network('10.10.0.0/20').should be_a Truth::Network

    #network = @config.network('10.10.0.0/20')
    #network.name_servers.should be_a Truth::Index
    #network.name_servers.should have_key :ns1
    #network.name_servers.should_not have_key :ns2

    #network.name_servers[:ns1].should be_a Truth::Host
    #network.name_servers[:ns1].object_id.
    #  should == @config.hosts[:ns1].object_id
  end

  it "automagically detects addressables" do
    @config.dsl_eval do
      host('u1r1.dc1') {
        name :pre_on
        interface(:eth0) {
          address '10.3.1.1'
        }
      }

      vip(:pre_off) {
        address '10.3.2.100'
      }

      network '10.3.1.0/24'

      vip(:post_on) {
        address '10.3.1.2'
      }

      host('u1r2.dc1') {
        name :post_on
        interface(:eth0) {
          address '10.3.0.255'
        }
      }
    end

    @config.networks.should have_key '10.3.1.0/24'
    @config.networks['10.3.1.0/24'].should be_a Truth::Network
    network = @config.network('10.3.1.0/24')

    network.addressables.should have_key '10.3.1.1'
    network.addressables['10.3.1.1'].should be_a Truth::Interface
    network.addressables['10.3.1.1'].context.name.should == :pre_on

    network.addressables.should_not have_key '10.3.2.100'

    network.addressables.should have_key '10.3.1.2'
    network.addressables['10.3.1.2'].should be_a Truth::VIP
    network.addressables['10.3.1.2'].name.should == :post_on

    network.addressables.should_not have_key '10.3.0.255'
  end

  it "correctly handles changes" do
    @config.dsl_eval do
      network '10.5.0.0/20'
      vip(:foo) {
        address '10.10.10.10'
      }
    end

    @config.networks.should have_key '10.5.0.0/20'
    @config.networks['10.5.0.0/20'].should be_a Truth::Network
    net = @config.network('10.5.0.0/20')
    net.addressables.should be_empty

    vip = @config.vips[:foo]
    vip.should be_a Truth::VIP
    vip.address.should == '10.10.10.10'

    # now open it up and change it
    # move the vip to the new network
    @config.dsl_eval do
      vip(:foo) {
        address '10.5.10.10'
      }
    end

    vip.address.should == '10.5.10.10'

    net.addressables.should have_key '10.5.10.10'
    net.addressables.should include vip
  end
end
