class Visitor
  attr_reader :name, :height, :preferences, :rides_ridden
  attr_accessor :spending_money, :total_money_spent

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete("$").to_i
    @total_money_spent = 0
    @rides_ridden = []
    @preferences = []
  end

  def add_preference(type)
    @preferences << type
  end

  def tall_enough?(ride_height)
    @height >= ride_height
  end

  def favorite_ride
    freq = @rides_ridden.inject(Hash.new(0)) { |key, value| key[value] += 1; key}
    @rides_ridden.max_by {|value| freq[value]}
  end
end
