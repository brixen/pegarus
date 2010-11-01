require 'spec/spec_helper'
require 'pegarus/machine'

describe "The return instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:return]
  end

  it "sets the next machine IP to the value popped from the stack" do
    @state.stack << 5
    @insn[@state]
    @state.stack.should == []
    @state.next_ip.should == 5
  end
end
