describe :ast_unless, :shared => true do
  it "returns 0 if the subject is empty" do
    pat = -Pegarus.pattern("abc")
    pat.match("").should == 0
  end

  it "returns nil of the pattern matches" do
    pat = -Pegarus.pattern("abc")
    pat.match("abcd").should be_nil
  end

  it "returns the index at the beginning of the pattern if the pattern does not match" do
    pat = -Pegarus.pattern("abc")
    pat.match("bcd").should == 0
  end

  it "returns nil if the compound pattern matches" do
    pat = -(Pegarus.pattern("a") + Pegarus.pattern("bc"))
    pat.match("abc").should be_nil
  end

  it "returns the index at the beginning of the pattern if the compound pattern does not match" do
    pat = Pegarus.pattern(1) + -(Pegarus.pattern("b") + Pegarus.pattern("d"))
    pat.match("abcd").should == 1
  end
end
