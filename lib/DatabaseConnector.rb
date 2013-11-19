class DatabaseConnector

  def initialize logger=nil
    if logger
      ActiveRecord::Base.logger = Logger.new(logger)
    end
  end

  def connect
    ActiveRecord::Base.establish_connection(
        :adapter => "mysql",
        :database  => "test"
    )
  end
end
