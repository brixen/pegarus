require 'spec/matching/evaluator/setup'
require 'spec/matching/shared/concatenation'

describe "Concatenation#match" do
  it_should_behave_like :ast_concatenation
end
