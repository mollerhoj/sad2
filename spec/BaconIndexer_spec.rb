require 'BaconIndexer'
require 'Person'

describe BaconIndexer do
  context "Find index of Kevin Bacon" do 
    it "should return 0" do 
      bacon_indexer = BaconIndexer.new 
      kevin_bacon = Person.new
      kevin_bacon.name = 'Kevin Bacon'
      bacon_indexer.index(kevin_bacon).should eq(0)
    end
  end

  context "Find index of John Wayne" do 
    it "should return 3" do 
      pending
      bacon_indexer = BaconIndexer.new 
      kevin_bacon = Person.new
      kevin_bacon.name = 'John Wayne'
      bacon_indexer.index(kevin_bacon).should eq(3)
    end
  end

  context "Find index of Jim Carry" do 
    it "should return 5" do 
      bacon_indexer = BaconIndexer.new 
      kevin_bacon = Person.new
      kevin_bacon.name = 'John Wayne'
      bacon_indexer.index(kevin_bacon).should eq(5)
    end
  end

end


