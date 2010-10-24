require 'spec/spec_helper'
require 'pegarus/machine'

describe "The capture instruction" do
  before :each do
    @state = Pegarus::Machine::State.new ""
    _, @insn = Pegarus::Machine::Instructions[:capture]
  end

  it "adds an entry [current index, <data>] in the captures list" do
    @state.captures.should == []
    @insn[@state, :data]
    @state.captures.should == [[0, :data]]
  end
end
