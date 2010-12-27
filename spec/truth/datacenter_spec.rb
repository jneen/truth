require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Truth::Datacenter do
  before :each do
    @config = new_configuration
  end

  it "can be declared without a block" do
    @config.dsl_eval do
      datacenter :abc
    end

    @config.datacenters.should have_key :abc
    @config.datacenters[:abc].should be_a Truth::Datacenter
  end

  it "automagically appears without declaring" do
    @config.dsl_eval do
      host('u99r8.def') {
        name :foo
      }
    end

    @config.datacenters.should have_key :def
    @config.datacenters[:def].should be_a Truth::Datacenter

    dc = @config.datacenter(:def)
    dc.locatables.should have_key 'u99r8'
    dc.locatables['u99r8'].should be_a Truth::Host
    dc.locatable('u99r8').name.should == :foo
  end

  it "has switches" do
    @config.dsl_eval do
      datacenter(:ghi) {
        switch(1) {
          address '10.5.1.2'
        }
      }
    end

    dc = @config.datacenter(:ghi)
    dc.switches.should have_key 1
    dc.switches[1].should be_a Truth::Switch
    dc.switches[1].address.should == '10.5.1.2'
  end
end
