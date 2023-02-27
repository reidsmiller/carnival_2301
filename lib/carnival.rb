class Carnival
  attr_reader :name, :all_rides, :summary_hash

  def initialize(name, duration)
    @name = name
    @duration = duration
    @all_rides = []
    @summary_hash = {}
    @all_visitors = []
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
    @all_rides.each do |ride|
      ride.rider_log.each {|visitor| @all_visitors << visitor}
    end
    @all_visitors.uniq!
    @all_visitors.length
  end

  def create_visitor_hash
    @all_visitors.to_h do |visitor|
      [visitor[0].name, create_visitor_stats(visitor[0])]
    end
  end

  def create_visitor_stats(visitor)
    visitor_stats = {
      favorite_ride: visitor.favorite_ride,
      total_money_spent: visitor.total_money_spent
    }
  end

  def create_ride_hash
    @all_rides.to_h do |ride|
      [ride.name, create_ride_stats(ride)]
    end
  end

  def create_ride_stats(ride)
    ride_stats = {
      rider_log: ride.rider_log,
      total_revenue: ride.total_revenue
    }
  end

  def create_summary_hash
    @summary_hash[:visitor_count] = visitor_count
    @summary_hash[:revenue_earned] = all_total_revenue
    @summary_hash[:visitors] = create_visitor_hash
    @summary_hash[:rides] = create_ride_hash
  end
end
