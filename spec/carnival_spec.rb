require 'rspec'
require './lib/carnival'

describe Carnival do
  describe '#initialize' do
    it 'exists and has attributes' do
      carnival = Carnival.new({start: '2022-11-11', end: '2022-11-13'})
      carnival2 = Carnival.new({start: '2022-11-8', end: '2022-11-13'})

      expect(carnival.start).to eq('2022-11-11')
      expect(carnival.end).to eq('2022-11-13')
      expect(carnival.duration).to eq '2 days'
      expect(carnival2.duration).to eq '5 days'
      expect(carnival.rides).to eq []
    end

    it 'can have rides' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
      ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      carnival = Carnival.new({start: '2022-11-11', end: '2022-11-13', rides: [ride1, ride2, ride3]})

      expect(carnival.rides).to eq [ride1, ride2, ride3]
    end
  end

  describe '#total_revenue' do
    it 'can calculate total revenue earned from all rides' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
      ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      carnival = Carnival.new({start: '2022-11-11', end: '2022-11-13', rides: [ride1, ride2, ride3]})

      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor3 = Visitor.new('Penny', 64, '$14')

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:thrilling)

      10.times {ride1.board_rider(visitor1)}
      ride2.board_rider(visitor2)
      7.times {ride3.board_rider(visitor3)}

      expect(ride1.total_revenue).to eq 10
      expect(ride2.total_revenue).to eq 5
      expect(ride3.total_revenue).to eq 14

      expect(carnival.total_revenue).to eq 29
    end
  end

  describe '#most_popular_ride' do
    it 'calculates the most popular ride based on total times rode' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      carnival = Carnival.new({start: '2022-11-11', end: '2022-11-13', rides: [ride1, ride3]})

      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 54, '$5')
      visitor3 = Visitor.new('Penny', 64, '$14')

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      7.times {ride1.board_rider(visitor1)}
      7.times {ride3.board_rider(visitor3)}
      ride3.board_rider(visitor2)

      expect(ride1.total_times_ridden).to eq 7
      expect(ride3.total_times_ridden).to eq 8

      expect(carnival.most_popular_ride).to eq ride3
    end
  end
end