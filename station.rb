class Station

  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def list_by_type(type)
    self.trains.select { |train| train.type == type }
  end
end