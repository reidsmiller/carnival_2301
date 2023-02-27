class Carnival
  attr_reader :name, :all_rides, :summary_hash

  def initialize(name)
    @name = name
    @all_rides = []
    @summary_hash = {}
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

  def visitor_count
    all_visitors = []
    @all_rides.each do |ride|
      ride.rider_log.each {|visitor| all_visitors << visitor}
    end
    all_visitors.uniq!
    all_visitors.length
  end

  def create_summary_hash
    @summary_hash[:visitor_count] = visitor_count
    @summary_hash[:revenue_earned] = all_total_revenue
  end
end
