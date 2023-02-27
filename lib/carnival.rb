class Carnival
  attr_reader :name, :all_rides

  def initialize(name)
    @name = name
    @all_rides = []
  end

  def add_ride(ride)
    @all_rides << ride
  end

  
end
