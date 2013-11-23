require 'Spec_helper'

describe Reporter do
  let(:output) { double('output').as_null_object }
  let(:bacon_indexer) { double('bacon_indexer').as_null_object }
  let(:movie_packer) { double('movie_packer').as_null_object }

  describe "Bacon index" do 
    context "Report the index of some person" do
      it "should report the index of the person" do
        reporter = Reporter.new output, bacon_indexer
        bacon_indexer.should_receive(:index).and_return(3)
        output.should_receive(:puts).with('The bacon index of Wayne is 3')
        reporter.report_bacon_index 'Wayne'
      end
    end
  end

  describe "Disk fit" do 
    context "Report movies that fits on medium disk" do
      it "should report a list of movies" do
        reporter = Reporter.new output, nil, movie_packer

        movies = []
        movies[0] = Movie.new
        movies[1] = Movie.new
        movies[2] = Movie.new
        movies[0].name = 'King Kong'
        movies[1].name = 'Batman'
        movies[2].name = 'Titanic'

        movie_packer.should_receive(:pack).with(5).and_return(movies)

        output.should_receive(:puts).with("These movies would fill up atleast half of the disk: King Kong, Batman, and Titanic")
        reporter.report_movies_fit_on_disk 5
      end
    end
  end
end
