require 'spec/spec_helper'
require 'pegarus/machine'

describe "The span instruction" do
  before :each do
    @state = Pegarus::Machine::State.new "abc"
    _, @insn = Pegarus::Machine::Instructions[:span]
  end

  it "advances the subject index while the current character is in the argument" do
    @insn[@state, "edcba"]
    @state.index.should == 3
  end

  it "does not advance the subject index if the subject is empty" do
    state = Pegarus::Machine::State.new ""
    @insn[state, "edcba"]
    state.index.should == 0
  end

  it "does not advance the subject index if the current character is not in the argument" do
    @insn[@state, "xyz"]
    @state.index.should == 0
  end

  it "does not set the machine failure state when there is not a match" do
    @insn[@state, "xyz"]
    @state.failure?.should be_false
  end
end
