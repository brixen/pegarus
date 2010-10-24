require 'spec/spec_helper'

describe "Difference.new" do
  it "converts the input to a pattern" do
    pattern = Pegarus::Difference.new 1, "a"
    pattern.first.should be_an_instance_of(Pegarus::Any)
    pattern.second.should be_an_instance_of(Pegarus::Character)
  end
end
