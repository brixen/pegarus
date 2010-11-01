require 'spec/spec_helper'
require 'pegarus/machine'

describe "The back_commit instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:back_commit]
  end

  it "assigns the subject index and capture list to the values on the stack" do
    @state.stack << 1 << 2 << 3 << [5, :data]
    @insn[@state, 5]
    @state.index.should == 3
    @state.captures.should == [5, :data]
  end

  it "assigns the machine IP to the value of the argument" do
    @state.ip.should == 0
    @state.stack << 1 << 2 << 3 << []
    @insn[@state, 5]
    @state.next_ip.should == 5
  end

  it "backtracks to a choice entry on the stack" do
    @state.stack << 1 << 2 << 3 << []
    @insn[@state, 5]
    @state.stack.should == [1]
  end

  it "does not set the machine failure state if a choice entry is found on the stack" do
    @state.failure?.should be_false
    @state.stack << 1 << 2 << 3 << []
    @insn[@state, 5]
    @state.failure?.should be_false
  end

  it "sets the machine failure state if no choice entry is found on the stack" do
    @state.failure?.should be_false
    @state.stack << 1
    @insn[@state, 5]
    @state.failure?.should be_true
  end
end
