require 'spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival = Carnival.new('Boulder County Fair')
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
    @ride1.board_rider(@visitor1)
    @ride1.board_rider(@visitor2)
    @ride1.board_rider(@visitor1)
    @ride3.board_rider(@visitor3)
    @ride3.board_rider(@visitor3)
  end

  describe '#iteration 3 - Carnival' do
    it 'can instantiate new class' do
      expect(@carnival.name).to eq('Boulder County Fair')
      expect(@carnival.all_rides).to eq([])
    end

    it 'can add rides' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.all_rides).to eq([@ride1, @ride2, @ride3])
    end

    it 'can tell us most popular ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.most_popular).to eq(@ride1)

      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)

      expect(@carnival.most_popular).to eq(@ride3)
    end

    it 'can tell us most profitable ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.most_profitable).to eq(@ride3)

      @ride2.board_rider(@visitor1)

      expect(@carnival.most_profitable).to eq(@ride2)
    end

    it 'can calculate total revenue from all rides' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.all_total_revenue).to eq(7)

      @ride2.board_rider(@visitor1)

      expect(@carnival.all_total_revenue).to eq(12)
    end
  end

  describe '#Iteration 4 - summary hash' do
    it 'creates hash that includes visitor count and revenue earned' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @carnival.create_summary_hash

      expect(@carnival.summary_hash[:visitor_count]).to eq(3)
      expect(@carnival.summary_hash[:revenue_earned]).to eq(@carnival.all_total_revenue)
    end

    it 'can generate a visitors favorite ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @ride2.board_rider(@visitor1)
      expect(@visitor1.favorite_ride).to eq('Carousel')
    end

    it 'adds list of visitors, each visitors favorite ride, and total money visitor spent' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @carnival.create_summary_hash
     
      expect(@carnival.summary_hash[:visitors]["Bruce"][:favorite_ride]).to eq('Carousel')
      expect(@carnival.summary_hash[:visitors]["Tucker"][:total_money_spent]).to eq(1)
    end
  end
end