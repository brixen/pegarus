require 'spec/spec_helper'

describe "Choice.new" do
  it "converts both inputs to patterns" do
    pattern = Pegarus::Choice.new 1, "a"
    pattern.first.should be_an_instance_of(Pegarus::Any)
    pattern.second.should be_an_instance_of(Pegarus::Character)
  end
end

describe "Choice#match" do
  it "returns nil if none of the patterns match" do
    pat = Pegarus.pattern("a") / Pegarus.pattern("b")
    pat.match("c").should be_nil
  end

  it "matches the first pattern if both match" do
    pat = Pegarus.pattern("aaa") / Pegarus.pattern("a")
    pat.match("aaa").should == 3
  end

  it "matches the second pattern if the first does not match" do
    pat = Pegarus.pattern("a") / Pegarus.pattern("bc")
    pat.match("bc").should == 2
  end
end
