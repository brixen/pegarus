require 'spec/matching/evaluator/setup'
require 'spec/matching/shared/unless'

describe "Unless#match" do
  it_should_behave_like :ast_unless
end
