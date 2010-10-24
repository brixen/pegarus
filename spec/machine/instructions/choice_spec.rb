require 'spec/spec_helper'
require 'pegarus/machine'

describe "The choice instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:choice]
  end

  it "pushes the alternate IP, current subject index, and captures list on the stack" do
    @state.stack.should == []
    @insn[@state, 5]
    @state.stack.should == [5, 0, []]
  end
end
