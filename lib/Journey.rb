require_relative 'oystercard'

class Journey
  MIN_FARE = 1
  FARE_PENALTY = 6
attr_accessor :journey

  def initialize
    @journey = {entry_station: nil, exit_station: nil}
    # @entry_station = []
    # @exit_station = []
  end


  def start_journey(station)
    @journey[:entry_station] = [station.station_name, station.zone]
    # @entry_station << station.station_name
    # @entry_station << station.zone
  end

  def finish_journey(station)
    @journey[:exit_station] = [station.station_name, station.zone]
    # @exit_station << station.station_name
    # @exit_station << station.zone
  end

  def complete?
  @journey[:entry_station] != nil && @journey[:exit_station] != nil
  #  !@entry_station.empty? && !@exit_station.empty?
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