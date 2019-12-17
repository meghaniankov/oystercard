require_relative 'station'

class OysterCard
  MAX_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :journey_history, :journey, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Top up is above maximum limit of #{MAX_LIMIT}" if exceeds_limit(amount)
    @balance += amount 
  end 

  def tap_in(station)
    fail "Balance below minimum fare of #{MIN_FARE}" if insufficient_balance 
    @entry_station= station 
  end

  def tap_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil 
  end

  def journey?
    @entry_station == nil ? false : true 
  end

  def exceeds_limit(amount)
    amount > MAX_LIMIT
  end

  def insufficient_balance 
    @balance < MIN_FARE
  end

  private

  def deduct(fare)
    @balance -= fare
  end 
end