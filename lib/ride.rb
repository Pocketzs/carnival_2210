class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue
  
  def initialize(attributes)
    @name           = attributes[:name]
    @min_height     = attributes[:min_height]
    @admission_fee  = attributes[:admission_fee]
    @excitement     = attributes[:excitement]
    @total_revenue  = 0
  end
end
