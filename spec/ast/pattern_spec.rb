require 'spec/spec_helper'

describe "Pegarus.pattern" do
  it "returns an Any pattern when passed an Integer" do
    Pegarus.pattern(5).should be_an_instance_of(Pegarus::Any)
  end

  it "returns an If Any pattern when passed a negative Integer" do
    pat = Pegarus.pattern(-1)
    pat.should be_an_instance_of(Pegarus::If)
    pat.pattern.should be_an_instance_of(Pegarus::Any)
  end

  it "returns an Character pattern when passed a String" do
    Pegarus.pattern("abc").should be_an_instance_of(Pegarus::Character)
  end

  it "returns a Set pattern when passed an Array" do
    Pegarus.pattern(["abc"]).should be_an_instance_of(Pegarus::Set)
  end

  it "retuns an Always pattern when passed true" do
    Pegarus.pattern(true).should be_an_instance_of(Pegarus::Always)
  end

  it "returns a Never pattern when passed false" do
    Pegarus.pattern(false).should be_an_instance_of(Pegarus::Never)
  end

  it "returns the instance unmodified when passed a Pattern" do
    pattern = Pegarus::Pattern.new
    Pegarus.pattern(pattern).should equal(pattern)
  end

  it "returns nil when passed nil" do
    Pegarus.pattern(nil).should be_nil
  end

  it "raises a Pegarus::InvalidPatternError when passed an Object" do
    lambda { Pegarus.pattern(Object.new) }.should raise_error(Pegarus::InvalidPatternError)
  end

  it "raises a Pegarus::InvalidPatternError when passed a Hash" do
    lambda { Pegarus.pattern({}) }.should raise_error(Pegarus::InvalidPatternError)
  end

  it "raises a Pegarus::InvalidPatternError when passed a Float" do
    lambda { Pegarus.pattern(4.2) }.should raise_error(Pegarus::InvalidPatternError)
  end
end

describe "Pattern#+@" do
  it "returns an If pattern" do
    p1 = Pegarus.pattern(1)
    pattern = +p1

    pattern.should be_an_instance_of(Pegarus::If)
  end
end

describe "Pattern#-@" do
  it "returns an Unless pattern" do
    p1 = Pegarus.pattern(1)
    pattern = -p1

    pattern.should be_an_instance_of(Pegarus::Unless)
  end
end

describe "Pattern#/" do
  it "returns a Choice of two patterns" do
    p1 = Pegarus.pattern(1)
    p2 = Pegarus.pattern("a")
    pattern = p1 / p2

    pattern.should be_an_instance_of(Pegarus::Choice)
    pattern.first.should equal(p1)
    pattern.second.should equal(p2)
  end
end

describe "Pattern#+" do
  it "returns a Concatenation of two patterns" do
    p1 = Pegarus.pattern(1)
    p2 = Pegarus.pattern("a")
    pattern = p1 + p2

    pattern.should be_an_instance_of(Pegarus::Concatenation)
    pattern.first.should equal(p1)
    pattern.second.should equal(p2)
  end
end

describe "Pegarus#-" do
  it "returns a Difference of two patterns" do
    p1 = Pegarus.pattern(1)
    p2 = Pegarus.pattern("a")
    pattern = p1 - p2

    pattern.should be_an_instance_of(Pegarus::Difference)
    pattern.first.should equal(p1)
    pattern.second.should equal(p2)
  end
end

describe "Pegarus#*" do
  it "returns a Product of two patterns" do
    p1 = Pegarus.pattern("a")
    pattern = p1 * 2

    pattern.should be_an_instance_of(Pegarus::Product)
    pattern.pattern.should equal(p1)
    pattern.count.should == 2
  end

  it "takes the absolute value of the multiplier" do
    p1 = Pegarus.pattern("a")
    pattern = p1 * -3

    pattern.should be_an_instance_of(Pegarus::Product)
    pattern.pattern.should equal(p1)
    pattern.count.should == 3
  end
end
