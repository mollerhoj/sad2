require 'Spec_helper'

describe Film do
  context "users and their ratings" do
    it "should give connections" do
      f = Film.new
      f.users = {1=>2,2=>3,4=>5}
      f.create_connections.should eq({[1,2]=>[1], [2,4]=>[2], [1,4]=>[3]})
    end
  end
end
