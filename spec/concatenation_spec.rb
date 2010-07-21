require 'spec/spec_helper'

describe "Concatenation.new" do
  it "converts both inputs to patterns" do
    pattern = Pegarus::Concatenation.new 1, "a"
    pattern.first.should be_an_instance_of(Pegarus::Any)
    pattern.second.should be_an_instance_of(Pegarus::Character)
  end
end

describe "Concatenation#match" do
  it "returns nil if the first pattern does not match" do
    pat = Pegarus.pattern(1) + Pegarus.pattern("a")
    pat.match("").should be_nil
  end

  it "returns nil if the second pattern does not match" do
    pat = Pegarus.pattern(1) + Pegarus.pattern("a")
    pat.match("ab").should be_nil
  end

  it "returns the index of the character following the matched substring" do
    pat = Pegarus.pattern(1) + Pegarus.pattern("ac")
    pat.match("aacbde").should == 3
  end
end
