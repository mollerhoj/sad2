require 'Spec_helper'

describe BaconIndexer do
  context "Kevin Bacon himself" do 
    it "should return 0" do 
      bacon_indexer = BaconIndexer.new 
      kevin_bacon = Actor.find(22591)
      bacon_indexer.index(kevin_bacon).should eq(0)
    end
  end

  context "A colleage of Kevin Bacon" do 
    it "should return 1" do 
      bacon_indexer = BaconIndexer.new 
      al_pacino = Actor.find(509689)
      bacon_indexer.index(al_pacino).should eq(1)
    end
  end

  context "Someone who has no connection" do 
    it "should return 5" do 
      bacon_indexer = BaconIndexer.new 
      kevin_bacon = Actor.find(4306)
      bacon_indexer.index(kevin_bacon).should eq(nil)
    end
  end

end


