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
end