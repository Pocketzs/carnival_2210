require './lib/ride'
require 'time'

class Carnival
  attr_reader :duration,
              :start,
              :end,
              :rides

  def initialize(attributes)
    @start = attributes[:start]
    @end = attributes[:end]
    @duration = "#{((Time.parse(@end)-Time.parse(@start))/86400).to_i} days"
    @rides = attributes[:rides] || []
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def most_popular_ride
    @rides.max_by { |ride| ride.total_times_ridden } 
  end
end