class Carnival
  attr_reader :name, :all_rides

  def initialize(name)
    @name = name
    @all_rides = []
  end

  def add_ride(ride)
    @all_rides << ride
  end

  def most_popular
    all_rides.max_by {|ride| ride.total_rides}
  end

  def most_profitable
    all_rides.max_by {|ride| ride.total_revenue}
  end

  def all_total_revenue
    all_rides.sum {|ride| ride.total_revenue}
  end
end
