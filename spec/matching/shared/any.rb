describe :ast_any, :shared => true do
  it "returns nil when the subject is empty" do
    Pegarus.pattern(1).match("").should be_nil
  end

  it "returns nil if there are not N characters to match in the subject" do
    Pegarus.pattern(3).match("ab").should be_nil
  end

  it "returns the index of the character following the matched substring" do
    Pegarus.pattern(3).match("abcd").should == 3
  end
end
