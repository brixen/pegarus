engine_is :rbx do
  require 'spec/matching/rubinius/setup'
  require 'spec/matching/shared/unless'

  describe "Unless#match" do
    it_should_behave_like :ast_unless
  end
end
