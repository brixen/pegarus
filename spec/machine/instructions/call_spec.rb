require 'spec/spec_helper'
require 'pegarus/machine'

describe "The call instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:call]
  end

  it "pushes the next IP onto the stack" do
    @state.stack.should == []
    @insn[@state, 5]
    @state.stack.should == [2]
  end

  it "sets the IP to the value of the argument" do
    @state.next_ip.should == 0
    @insn[@state, 5]
    @state.next_ip.should == 5
  end
end
