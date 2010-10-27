require 'spec/spec_helper'
require 'pegarus/machine'

describe "The fail_twice instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    @state.stack << 3 << [] << 1 << 2
    _, @insn = Pegarus::Machine::Instructions[:fail_twice]
  end

  it "discards the alternate stack info pushed by a choice instruction" do
    @insn[@state]
    @state.stack.should == [3]
  end

  it "does not change the machine IP" do
    @state.ip.should == 0
    @insn[@state]
    @state.ip.should == 0
  end

  it "sets the machine state to failure" do
    @state.failure?.should be_false
    @insn[@state]
    @state.failure?.should be_true
  end
end
