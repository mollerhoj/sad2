require 'Spec_helper'

describe Actor do
  before(:all) do
    dbc = DatabaseConnector.new
    dbc.connect 
  end

  describe "Find the last name of actor with id 358968" do
    it "has the last name Pacino" do
      p = Actor.find(358968)
      p.last_name.should eq("Pacino")
    end
  end

  describe "Find the colleages of actor with id 358968" do
    it "has the last name Pacino" do
      p = Actor.find(358968)
      p.find_colleages.length.should eq(54)
    end
  end

end
