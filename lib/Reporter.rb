class Reporter
  def initialize (output,bacon_indexer)
    @output = output ||= STDOUT
    @bacon_indexer = bacon_indexer ||= BaconIndexer.new
  end

  def report_bacon_index name
    person = find_person_by_name name
    bacon_index = @bacon_indexer.index person
    @output.puts "The bacon index of #{name} is #{bacon_index}"
  end

  def find_person_by_name name
    p = Person.new 
    p.name = name
    p
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
