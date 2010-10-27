describe :ast_if, :shared => true do
  it "returns nil if the subject is empty" do
    pat = +Pegarus.pattern("abc")
    pat.match("").should be_nil
  end

  it "returns nil if the pattern does not match" do
    pat = +Pegarus.pattern("abc")
    pat.match("abdc").should be_nil
  end

  it "returns the index at the beginning of the pattern if the pattern matches" do
    pat = +Pegarus.pattern("abc")
    pat.match("abcd").should == 0
  end

  it "returns nil if the compound pattern does not match" do
    pat = +(Pegarus.pattern("a") + Pegarus.pattern("c"))
    pat.match("abc").should be_nil
  end

  it "returns the index at the beginning of the pattern if the compound pattern matches" do
    pat = Pegarus.pattern(1) + +(Pegarus.pattern("b") + Pegarus.pattern("c"))
    pat.match("abcd").should == 1
  end
end
