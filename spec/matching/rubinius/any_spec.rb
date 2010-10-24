engine_is :rbx do
  require 'spec/matching/rubinius/setup'
  require 'spec/matching/shared/any'

  describe "Any#match" do
    it_should_behave_like :ast_any
  end
end
