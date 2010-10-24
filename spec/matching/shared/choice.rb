describe :ast_choice, :shared => true do
  it "returns nil if none of the patterns match" do
    pat = Pegarus.pattern("a") / Pegarus.pattern("b")
    pat.match("c").should be_nil
  end

  it "matches the first pattern if both match" do
    pat = Pegarus.pattern("aaa") / Pegarus.pattern("a")
    pat.match("aaa").should == 3
  end

  it "matches the second pattern if the first does not match" do
    pat = Pegarus.pattern("a") / Pegarus.pattern("bc")
    pat.match("bc").should == 2
  end
end
