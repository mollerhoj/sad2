require 'Reporter'

describe Reporter do
  let(:output) { double('output').as_null_object }
  let(:bacon_indexer) { double('bacon_indexer').as_null_object }

  describe "Bacon index" do 

    context "Find index of some person" do
      it "should report the index of the person" do
        reporter = Reporter.new output, bacon_indexer
        bacon_indexer.should_receive(:index).and_return(3)
        output.should_receive(:puts).with('The bacon index of John Wayne is 3')
        reporter.report_bacon_index 'John Wayne'
      end
    end

  end
end
