require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Truth::Host do
  before :each do
    @host = new_host
  end

  it "renders to dsl" do
    @host.should respond_to :to_dsl
    @host.to_dsl.should be_a String
    #TODO: figure out a better way to test this.
  end
end
