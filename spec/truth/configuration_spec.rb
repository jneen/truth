describe Truth::Configuration do
  before :each do
    @config = new_configuration
  end

  it "is accessible by version" do
    Truth(@config.version).object_id.should == @config.object_id
  end

  it "is its own configuration" do
    @config.configuration.should == @config
  end
end
