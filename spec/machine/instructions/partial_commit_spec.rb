require 'spec/spec_helper'
require 'pegarus/machine'

describe "The partial_commit instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:partial_commit]
  end

  it "assigns the machine IP to the value of the argument" do
    @state.stack << 1 << 2 << 3 << [5, :data]
    @state.next_ip.should == 0
    @insn[@state, 5]
    @state.next_ip.should == 5
  end

  it "updates the subject index in the top stack entry" do
    @state.stack << 1 << 2 << 3 << [5, :data]
    @state.index = 8
    @insn[@state, 5]
    @state.stack.should == [1, 2, 8, []]
  end

  it "updates the capture list in the top stack entry" do
    @state.stack << 1 << 2 << 3 << [5, :data]
    @state.captures.replace [8, :data]
    @insn[@state, 5]
    @state.stack.should == [1, 2, 0, [8, :data]]
  end
end
