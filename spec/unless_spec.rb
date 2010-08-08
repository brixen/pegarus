require 'spec/spec_helper'

describe "Unless.new" do
  it "converts the input to a pattern" do
    pattern = Pegarus::Unless.new "a"
    pattern.pattern.should be_an_instance_of(Pegarus::Character)
  end
end

describe "Unless#match" do
  it "returns nil if the first pattern does not match" do
    pat = Pegarus.pattern(1) + -Pegarus.pattern("a")
    pat.match("").should be_nil
  end

  it "returns nil if the second pattern match" do
    pat = Pegarus.pattern(1) + -Pegarus.pattern("b")
    pat.match("ab").should be_nil
  end

  it "returns the index of the character following the matched substring" do
    pat = Pegarus.pattern(1) + -Pegarus.pattern("xx")
    pat.match("aacbde").should == 1
  end
end

