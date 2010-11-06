describe :ast_grammar, :shared => true do
  before :each do
    @grammar = Pegarus.grammar
    @grammar.B = Pegarus.pattern("a") + -Pegarus.pattern(1)
    @grammar.S = (@grammar.B / Pegarus.pattern("b")) * 1
    @grammar.start = :S
  end

  it "returns nil if the grammar does not match" do
    @grammar.match("cab").should be_nil
  end

  it "returns the index following the last matched character" do
    @grammar.match("bab").should == 1
  end

  it "returns the index past the end of the subject when the full subject matches" do
    @grammar.match("bbba").should == 4
  end
end
