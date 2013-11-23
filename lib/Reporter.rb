class Reporter
  def initialize (output,bacon_indexer)
    @output = output ||= STDOUT
    @bacon_indexer = bacon_indexer ||= BaconIndexer.new
  end

  def report_bacon_index last_name
    actor = Actor.find_by_last_name last_name
    bacon_index = @bacon_indexer.index actor
    @output.puts "The bacon index of #{last_name} is #{bacon_index}"
  end

  def find_person_by_name name
    a = Actor.new 
    a.name = name
    a
  end
end

class Output
  def messages
    @messages ||= []
  end

  def puts (message)
    messages << message
  end
end

