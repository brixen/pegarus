require 'spec/spec_helper'
require 'pegarus/machine'

describe "The jump instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:jump]
  end

  it "sets the IP to the value of the argument" do
    @state.ip.should == 0
    @insn[@state, 5]
    @state.ip.should == 5
  end
end
