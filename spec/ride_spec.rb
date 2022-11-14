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

    it 'reduces the riders spending money and increases total revenue by the admission fee' do
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

    it 'does not board a visitor if they dont have a matching preference' do
      ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor1.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor3.add_preference(:thrilling)

      expect(visitor1.preferences).to eq [:gentle]
      expect(visitor3.preferences).to eq [:gentle, :thrilling]
      expect(ride3.excitement).to eq :thrilling

      ride3.board_rider(visitor1)
      ride3.board_rider(visitor3)

      expect(visitor1.spending_money).to eq 10
      expect(visitor3.spending_money).to eq 13

      expect(ride3.rider_log).to eq({visitor3 => 1})
    end

    it 'does not board a visitor if they are not tall enough' do
      ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:thrilling)

      expect(ride3.min_height).to eq 54
      expect(visitor2.tall_enough?(54)).to be false

      ride3.board_rider(visitor2)

      expect(visitor2.spending_money).to eq 5
      expect(ride3.rider_log).to eq({})
    end
  end
end