require './lib/visitor'
class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log
  
  def initialize(attributes)
    @name           = attributes[:name]
    @min_height     = attributes[:min_height]
    @admission_fee  = attributes[:admission_fee]
    @excitement     = attributes[:excitement]
    @total_revenue  = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    @rider_log[visitor] += 1
  end
end
