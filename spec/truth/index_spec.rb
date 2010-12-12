require File.join(File.dirname(__FILE__), '..', 'spec_helper')
include Truth

describe Index do
  before :each do
    @name_key = Faker::Lorem.word
    @sort_key = Faker::Lorem.word

    @sorted_mocks = (0..5).map do |i|
      mock(
        @name_key => :"name_#{i}",
        @sort_key => :"sort_#{i}",
        :i => i,
        :inspect => "#<mock [ #{i} ]>"
      )
    end

    @mocks = @sorted_mocks.shuffle

    @index = Index.new(
      :name_key => @name_key,
      :sort_key => @sort_key
    )
  end

  it "can be accessed as a hash" do

    m = @mocks.first
    @index << m

    @index[:"name_#{m.i}"].should == m
  end

  it "can be accessed as a list, sorted" do
    @mocks.each do |mock|
      @index << mock
    end

    @index.list.should == @sorted_mocks
  end

  it "is enumerable" do
    @index.should respond_to :to_a
    @index.should respond_to :each
    @index.should respond_to :include?

    @mocks.each do |mock|
      @index << mock
    end

    @index.list.each_with_index do |mock, i|
      mock.i.should == i
    end

    @mocks.each do |mock|
      @index.should include mock
    end
  end
end
