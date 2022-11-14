require 'rspec'
require './lib/ride'

describe Ride do
  describe '#initialize' do
    it 'exists and has attributes' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

      expect(ride1).to be_a Ride
      expect(ride1.name).to eq 'Carousel'
      expect(ride1.min_height).to eq 24
      expect(ride1.admission_fee).to eq 1
      expect(ride1.excitement).to eq :gentle
      expect(ride1.total_revenue).to eq 0
    end
  end

  describe '#rider_log' do
    it 'starts as an empty hash for visitors and how many times they rode' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      
      expect(ride1.rider_log).to eq({})
    end
  end

  describe '#board_rider' do
    it 'records visitors in the rider log and how many times they rode' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)

      expect(ride1.rider_log).to eq({})

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expect(ride1.rider_log).to eq({visitor1 => 2, visitor2 => 1})
    end

    it 'reduces the riders spending money by the admission fee' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)

      expect(visitor1.spending_money).to eq 10
      expect(visitor2.spending_money).to eq 5

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expect(visitor1.spending_money).to eq 8
      expect(visitor2.spending_money).to eq 4

      expect(ride1.total_revenue).to eq 3
    end
  end
end