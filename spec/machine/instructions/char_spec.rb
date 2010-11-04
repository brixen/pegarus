require 'spec/spec_helper'
require 'pegarus/machine'

describe "The char instruction" do
  before :each do
    @state = Pegarus::Machine::State.new "abc"
    _, @insn = Pegarus::Machine::Instructions[:char]
  end

  it "advances the subject index if the character matches" do
    @state.index.should == 0
    @insn[@state, "a"]
    @state.index.should == 1
  end

  it "does not advance the subject index if the charater does not match" do
    @state.index.should == 0
    @insn[@state, "b"]
    @state.index.should == 0
  end

  it "sets the machine state to failure if current index exceeds subject length" do
    @state.failure?.should be_false
    @state.index = 3
    @insn[@state, "a"]
    @state.failure?.should be_true
  end

  it "sets the machine state to failure if the character does not match" do
    @state.failure?.should be_false
    @insn[@state, "b"]
    @state.failure?.should be_true
  end
end
