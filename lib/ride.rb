class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

  def initialize(ride_info)
    @name = ride_info[:name]
    @min_height = ride_info[:min_height]
    @admission_fee = ride_info[:admission_fee]
    @excitement = ride_info[:excitement]
    @total_revenue = 0
    @rider_log = {}
  end

  def board_rider(visitor)
    visitor.spending_money = visitor.spending_money - @admission_fee
    if @rider_log.include?(visitor)
      @rider_log[visitor] += 1
    else
      @rider_log[visitor] = 1
    end
  end

end
