engine_is :rbx do
  require 'spec/matching/rubinius/setup'
  require 'spec/matching/shared/character'

  describe "Character#match" do
    it_should_behave_like :ast_character
  end
end
