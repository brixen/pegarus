engine_is :rbx do
  require 'spec/matching/rubinius/setup'
  require 'spec/matching/shared/if'

  describe "If#match" do
    it_should_behave_like :ast_if
  end
end
