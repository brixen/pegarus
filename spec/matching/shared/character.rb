describe :ast_character, :shared => true do
  it "returns nil when the subject is empty" do
    Pegarus.pattern("a").match("").should be_nil
  end

  it "returns nil when the subject does not match completely" do
    Pegarus.pattern("abc").match("abde").should be_nil
  end

  it "returns the index of the character following the matched substring" do
    Pegarus.pattern("abc").match("abcde").should == 3
  end

  it "returns 0 when pattern is empty" do
    Pegarus.pattern("").match("abc").should == 0
  end
end
