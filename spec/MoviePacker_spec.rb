require 'Spec_helper'

describe MoviePacker do
  context "Disk if of size 0" do 
    it "chooses movies that fit on disk" do
      movie_packer = MoviePacker.new
      movie_packer.pack(0).should eq []
    end
  end

  context "Disk if of size 0" do 
     it "chooses movies that fit on disk of size 5" do
      movie_packer = MoviePacker.new
      movie_packer.pack(5).should eq ['1','2','3','4','5']
    end
  end
end



    
