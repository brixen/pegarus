require 'spec/spec_helper'
require 'pegarus/machine'

describe "The fail instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:fail]
  end

  it "does not clear the failure if the stack is empty" do
    @state.failure?.should be_false
    @state.stack.should be_empty
    @insn[@state]
    @state.failure?.should be_true
  end

  it "does not clear the failure state if the stack only contains return address labels" do
    @state.failure?.should be_false
    @state.stack << 1 << 2 << 3
    @insn[@state]
    @state.stack.should be_empty
    @state.failure?.should be_true
  end

  it "clears the failure state and assigns the IP, subject index, and captures list to the values on the stack" do
    @state.failure?.should be_false
    @state.stack << 1 << 2 << 3 << [] << 4
    @insn[@state]
    @state.stack.should == [1]
    @state.failure?.should be_false
    @state.ip.should == 2
    @state.index.should == 3
  end
end
