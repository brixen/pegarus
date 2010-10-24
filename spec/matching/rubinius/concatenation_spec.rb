engine_is :rbx do
  require 'spec/matching/rubinius/setup'
  require 'spec/matching/shared/concatenation'

  describe "Concatenation#match" do
    it_should_behave_like :ast_concatenation
  end
end
