require 'spec/spec_helper'

describe "If.new" do
  it "converts the input to a pattern" do
    pattern = Pegarus::If.new "a"
    pattern.pattern.should be_an_instance_of(Pegarus::Character)
  end
end
