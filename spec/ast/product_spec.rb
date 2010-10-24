require 'spec/spec_helper'

describe "Product.new" do
  it "converts the first input to a pattern" do
    pattern = Pegarus::Product.new "a", 1
    pattern.first.should be_an_instance_of(Pegarus::Character)
  end

  it "calls #to_int to convert the second input" do
    obj = mock("multiplier")
    obj.should_receive(:to_int).and_return(2)

    pattern = Pegarus::Product.new "a", obj
    pattern.second.should == 2
  end

  it "raises a TypeError if the second input is nil" do
    lambda { Pegarus::Product.new "a", nil }.should raise_error(TypeError)
  end

  it "raises a TypeError if the second input is a String" do
    lambda { Pegarus::Product.new "a", "b" }.should raise_error(TypeError)
  end

  it "raises a TypeError if the second input is an Object" do
    lambda { Pegarus::Product.new "a", Object.new }.should raise_error(TypeError)
  end
end
