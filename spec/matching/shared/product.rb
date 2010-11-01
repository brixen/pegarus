describe :ast_product, :shared => true do
  it "returns nil if the pattern does not match count times" do
    pat = Pegarus.pattern("a") * 3
    pat.match("aab").should be_nil
  end

  it "returns the previous index when matching zero or more and there is no match" do
    pat = Pegarus.pattern("a") * 0
    pat.match("bcde").should == 0
  end

  it "returns the index of the character following the matched substring" do
    pat = Pegarus.pattern("ab") * 2
    pat.match("ababcde").should == 4
  end

  it "matches with a complex pattern" do
    pat = (Pegarus.pattern("a") / Pegarus.pattern("b")) * 2
    pat.match("abbaabc").should == 6
  end
end
