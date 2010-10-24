engine_is :rbx do
  require 'spec/matching/rubinius/setup'
  require 'spec/matching/shared/difference'

  describe "Difference#match" do
    it_should_behave_like :ast_difference
  end
end
