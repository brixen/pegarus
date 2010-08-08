require 'spec/spec_helper'

describe "If.new" do
  it "converts the input to a pattern" do
    pattern = Pegarus::If.new "a"
    pattern.pattern.should be_an_instance_of(Pegarus::Character)
  end
end

describe "If#match" do
  it "returns nil if the first pattern does not match" do
    pat = Pegarus.pattern(1) + +Pegarus.pattern("a")
    pat.match("").should be_nil
  end

  it "returns nil if the second pattern does not match" do
    pat = Pegarus.pattern(1) + +Pegarus.pattern("c")
    pat.match("ab").should be_nil
  end

  it "returns the index of the character following the matched substring" do
    pat = Pegarus.pattern(1) + +Pegarus.pattern("ac")
    pat.match("aacbde").should == 1
  end
end
