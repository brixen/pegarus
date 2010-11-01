require 'spec/spec_helper'
require 'pegarus/machine'

describe "The commit instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:commit]
  end

  it "discards the alternate stack info pushed by a choice instruction" do
    @state.stack << 3 << [] << 1 << 2
    @insn[@state, 5]
    @state.stack.should == [3]
  end

  it "sets the machine IP to the value of the argument" do
    @state.stack << [] << 1 << 2
    @insn[@state, 5]
    @state.next_ip.should == 5
  end
end
