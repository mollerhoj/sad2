require 'orm/Actor'
require 'DatabaseConnector'

describe Actor do
  before(:all) do
    dbc = DatabaseConnector.new
    dbc.connect 
  end

  describe "Find the last name of actor with id 358968" do
    it "has the last name Pacino" do
      p = Actor.find(358968)
      p.last_name.should == "Pacino"
    end
  end
end
