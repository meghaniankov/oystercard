require_relative 'oystercard'


class Journey
  MIN_FARE = 1
  FARE_PENALTY = 6
attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = []
    @exit_station = []
    @entry_station_details = []
    @exit_station_details = []
  end

  def start_journey(station)
    @entry_station << station.station_name
    @entry_station << station.zone
  end

  def finish_journey(station)
    @exit_station << station.station_name
    @exit_station << station.zone
  end

  def complete?
   !@entry_station.empty? && !@exit_station.empty?
  end

  def fare
    if complete?
      MIN_FARE
    else
      FARE_PENALTY
    end
  end



  # def log_history
  #   OyserCard.journey_history << {entry_station: @entry_station, exit_station: @exit_station}
  # end



end