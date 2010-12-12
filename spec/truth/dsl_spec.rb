require File.join(File.dirname(__FILE__), '..', 'spec_helper')

def config(v, version)
  Truth version do
    host(:ns01) {
      loc v[:loc1]

      interface(:eth0) {
        address v[:net1][:ip1]
        mac Faker::Computer.mac_address
      }

      # this host is on both nets
      interface(:eth1) {
        address v[:net2][:ip1]
        mac Faker::Computer.mac_address
      }
    }

    network(v[:net1][:cidr]) {
      name_server :ns01
      name_server :ns02
    }

    network(v[:net2][:cidr]) {
      name_server :ns01
    }

    host(:ns02) {
      loc v[:loc2]

      interface(:eth0) {
        address v[:net1][:ip2].to_s
        mac Faker::Computer.mac_address
      }
    }
  end
end

describe Truth::Dsl do
  include Builders

  before :each do
    @v = {}

    @v[:net1] = {}
    @v[:net1][:cidr] = '10.0.1.0/24'
    @v[:net1][:ip1]  = '10.0.1.5'
    @v[:net1][:ip2]  = '10.0.1.6'

    @v[:net2] = {}
    @v[:net2][:cidr] = '10.10.0.0/20'
    @v[:net2][:ip1]  = '10.10.0.201'
    @v[:net2][:ip2]  = '10.10.0.202'

    @v[:loc1] = Faker::Computer.loc
    @v[:loc2] = Faker::Computer.loc
    @v[:loc3] = Faker::Computer.loc
    @v[:loc4] = Faker::Computer.loc
  end

  it "correctly parses dsl" do
    cfg = config(@v, 1)
    cfg.should be_a Truth::Configuration
    cfg.networks.map(&:cidr).should include(
      CIDR(@v[:net1][:cidr])
    )

    net1 = cfg.network(CIDR(@v[:net1][:cidr]))

    net1.should be_a Truth::Network
    net1.interfaces.should be_a Truth::Index

    net1.interfaces.map(&:address).map(&:to_s).sort.should == [
      @v[:net1][:ip1],
      @v[:net1][:ip2]
    ].sort

  end

  it "correctly renders dsl" do
    cfg = config(@v, 2)
    cfg.to_dsl.should be_a String

    evald = eval(cfg.to_dsl)
    evald.should be_a Truth::Configuration
    evald.to_dsl.should == cfg.to_dsl
  end
end
