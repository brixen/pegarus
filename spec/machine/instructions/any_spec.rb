require 'spec/spec_helper'
require 'pegarus/machine'

describe "The any instruction" do
  before :each do
    @state = Pegarus::Machine::State.new "abc"
    _, @insn = Pegarus::Machine::Instructions[:any]
  end

  it "advances the subject if there are count characters remaining" do
    @state.failure?.should be_false
    @insn[@state, 3]
    @state.index.should == 3
    @state.failure?.should be_false
  end

  it "does not advance the subject if there are less than count characters remaining" do
    @state.failure?.should be_false
    @insn[@state, 4]
    @state.index.should == 0
  end

  it "sets the machine state to failure if there are less than count characters remaining" do
    @state.failure?.should be_false
    @insn[@state, 4]
    @state.failure?.should be_true
  end
end
