class BaconIndexer
  def index actor
    if actor.last_name == 'Bacon'
      return 0
    else
      queue = actor.find_colleages.dup.map do |a|
        [1,a]
      end
      visited = {}
      bacon_found = false
      until queue.empty? or bacon_found
        c = queue.shift

        if c[1].last_name == 'Bacon'
          bacon_found = true
          return c[0]
        else
          new_actors = c[1].find_colleages
          uniq_new_actors = new_actors.select {|a| !visited.has_key?(a)}

          uniq_new_actors.each do |a|
            visited[a] = true
          end

          conq = uniq_new_actors.map do |a|
            [c[0]+1,a]
          end

          queue.concat(conq)
        end
      end
    end
  end
end
