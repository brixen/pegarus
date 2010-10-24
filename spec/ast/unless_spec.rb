require 'spec/spec_helper'

describe "Unless.new" do
  it "converts the input to a pattern" do
    pattern = Pegarus::Unless.new "a"
    pattern.pattern.should be_an_instance_of(Pegarus::Character)
  end
end
