require 'Person'

describe Person do
  context "Find the name of person with id=5" do
    p = Person.Find(id: 5)
    p.name.should == "James"
  end
end
