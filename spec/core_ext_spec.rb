describe String do
  before :each do
    @stanza = [
      %|one|,
      %|  two|,
      %|  three|,
      %|four|,
      %| five|
    ].join("\n")
  end

  it "indents with no args" do
    @stanza.indent.should == [
      %|  one|,
      %|    two|,
      %|    three|,
      %|  four|,
      %|   five|
    ].join("\n")
  end

  it "indents with a positive space count" do
    @stanza.indent(1).should == [
      %| one|,
      %|   two|,
      %|   three|,
      %| four|,
      %|  five|
    ].join("\n")
  end

  it "indents with a negative space count" do
    @stanza.indent(-1).should == [
      %|ne|,
      %| two|,
      %| three|,
      %|our|,
      %|five|
    ].join("\n")
  end
end
