require 'spec/spec_helper'

describe "Pegarus.grammar" do
  it "returns a Grammar with empty start rule when passed no arguments" do
    grammar = Pegarus.grammar

    grammar.should be_an_instance_of(Pegarus::Grammar)
    grammar.start.should be_nil
  end

  it "returns a Grammar with start rule :S corresponding to the Pattern passed" do
    pattern = Pegarus.pattern 1
    grammar = Pegarus.grammar pattern

    grammar.should be_an_instance_of(Pegarus::Grammar)
    grammar.start.should == :S
    grammar.S.pattern.should equal(pattern)
  end

  it "returns a Grammar with start symbol corresponding to the Symbol passed" do
    grammar = Pegarus.grammar :token

    grammar.should be_an_instance_of(Pegarus::Grammar)
    grammar.start.should == :token
    grammar.token.pattern.should be_nil
  end

  it "returns a Grammar with start rule corresponding to the Symbol and Pattern passed" do
    pattern = Pegarus.pattern 1
    grammar = Pegarus.grammar :token, pattern

    grammar.should be_an_instance_of(Pegarus::Grammar)
    grammar.start.should == :token
    grammar.token.pattern.should equal(pattern)
  end

  it "returns a Grammar with start rule corresponding to the Variable passed" do
    variable = Pegarus.variable :token, "abc"
    grammar = Pegarus.grammar variable

    grammar.should be_an_instance_of(Pegarus::Grammar)
    grammar.start.should == :token
    grammar.token.pattern.should equal(variable.pattern)
  end
end

describe "Pegarus::Grammar" do
  it "returns a Variable instance with the name of the method invoked" do
    grammar = Pegarus.grammar
    variable = grammar.start_rule
    variable.name.should == :start_rule
    variable.pattern.should be_nil
  end

  it "converts the pattern into a Pegarus pattern" do
    grammar = Pegarus.grammar
    grammar.start_rule = ["!&"]
    grammar.start_rule.pattern.should be_an_instance_of(Pegarus::Set)
  end
end
