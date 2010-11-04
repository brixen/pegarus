require 'spec/spec_helper'
require 'pegarus/machine'

describe "The charset instruction" do
  before :each do
    @state = Pegarus::Machine::State.new "abc"
    _, @insn = Pegarus::Machine::Instructions[:charset]
  end

  it "advances the subject index if the character matches a set with one String" do
    @state.index.should == 0
    @insn[@state, ["abcd"]]
    @state.index.should == 1
  end

  it "advances the subject index if the character matches a set with one Range" do
    @state.index.should == 0
    @insn[@state, ["a".."d"]]
    @state.index.should == 1
  end

  it "advances the subject index if the character matches a set with a String and Range" do
    @state.index.should == 0
    @insn[@state, ["pqrs", "a".."d"]]
    @state.index.should == 1
  end

  it "does not advance the subject index if the character does not match" do
    @state.index.should == 0
    @insn[@state, ["bcd", "d".."g"]]
    @state.index.should == 0
  end

  it "sets the machine failure state if the character does not match" do
    @state.failure?.should be_false
    @insn[@state, ["bcd", "d".."g"]]
    @state.failure?.should be_true
  end
end
