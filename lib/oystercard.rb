require_relative 'station'
require_relative 'Journey'

class OysterCard
  MAX_LIMIT = 90
  # MIN_FARE = 1
  attr_reader :balance, :journey_history, :journey, :entry_station, :exit_station, :current_journey

  def initialize
    @balance = 0
    # @entry_station = nil
    # @exit_station = nil
    @journey_history = []
    @current_journey = nil
  end

  def top_up(amount)
    fail "Top up is above maximum limit of #{MAX_LIMIT}" if exceeds_limit(amount)
    @balance += amount 
  end 

  # def tap_in(station)
  #   fail "Balance below minimum fare of #{MIN_FARE}" if insufficient_balance 
  #   @entry_station = station 
  # end

  def tap_in(station)
    @current_journey = Journey.new
    fail "Balance below minimum fare of #{Journey::MIN_FARE}" if insufficient_balance 
    @current_journey.start_journey(station) 
    add_to_journey
  end

  def add_to_journey
    @journey_history << {entry_station: @current_journey.entry_station, exit_station: @current_journey.exit_station}
  end

  # def tap_out(station)
  #   deduct(MIN_FARE) if journey?
  #   @exit_station = station
  #   @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
  #   @entry_station = nil 
  # end

  def tap_out(station)
    @current_journey.finish_journey(station) 
    deduct(@current_journey.fare) 
    # unless complete? 
    #   @journey_history.pop
    # end
    # add_to_journey
    # @journey_history << {entry_station: @current_journey.entry_station, exit_station: @current_journey.exit_station}
  end


  def complete?
    @current_journey.complete?
  end

  def exceeds_limit(amount)
    amount > MAX_LIMIT
  end

  def insufficient_balance 
    @balance < Journey::MIN_FARE
  end

  private

  def deduct(fare)
    @balance -= fare
  end 
end