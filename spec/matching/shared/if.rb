describe :ast_if, :shared => true do
  it "returns nil if the first pattern does not match" do
    pat = Pegarus.pattern(1) + +Pegarus.pattern("a")
    pat.match("").should be_nil
  end

  it "returns nil if the second pattern does not match" do
    pat = Pegarus.pattern(1) + +Pegarus.pattern("c")
    pat.match("ab").should be_nil
  end

  it "returns the index of the character following the matched substring" do
    pat = Pegarus.pattern(1) + +Pegarus.pattern("ac")
    pat.match("aacbde").should == 1
  end
end
