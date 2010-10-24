require 'spec/spec_helper'

describe "Choice.new" do
  it "converts both inputs to patterns" do
    pattern = Pegarus::Choice.new 1, "a"
    pattern.first.should be_an_instance_of(Pegarus::Any)
    pattern.second.should be_an_instance_of(Pegarus::Character)
  end
end
