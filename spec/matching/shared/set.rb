describe :ast_set, :shared => true do
  it "returns nil when the subject is empty" do
    Pegarus.pattern(["abc"]).match("").should be_nil
  end

  it "returns nil when the character at subject index is not in the set" do
    Pegarus.pattern(["abc"]).match("d").should be_nil
  end

  it "returns the index of the character following the matching character" do
    Pegarus.pattern(["abc"]).match("b").should == 1
  end

  it "matches with a complex set" do
    pat = Pegarus.pattern(["_", "A".."Z", "a".."z"])
    pat.match("_").should == 1
    pat.match("q").should == 1
    pat.match("J").should == 1
  end

  it "matches with a complex pattern" do
    pat = Pegarus.pattern(["_", "A".."Z", "a".."z"]) * 1
    pat.match("_someValue = 1234").should == 10
  end
end
