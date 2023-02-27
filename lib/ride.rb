class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log, :total_rides

  def initialize(ride_info)
    @name = ride_info[:name]
    @min_height = ride_info[:min_height]
    @admission_fee = ride_info[:admission_fee]
    @excitement = ride_info[:excitement]
    @total_revenue = 0
    @rider_log = {}
    @total_rides = 0
  end

  def board_rider(visitor)
    if requirement_check(visitor)
      visitor.spending_money = visitor.spending_money - @admission_fee
      @total_revenue = @total_revenue + @admission_fee
      @total_rides += 1
      if @rider_log.include?(visitor)
        @rider_log[visitor] += 1
      else
        @rider_log[visitor] = 1
      end
    end
  end

  def requirement_check(visitor)
    true if visitor.preferences.include?(@excitement) && visitor.tall_enough?(@min_height) && visitor.spending_money >= @admission_fee
  end
end
