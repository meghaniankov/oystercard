require_relative 'oystercard'
require_relative 'station'
require_relative 'journey'

card = OysterCard.new
card.top_up(50)
station1 = Station.new("Paddington", 1)
station2 = Station.new("Kings Cross", 3)
card.tap_in(station1)
# card.tap_out(station2)
# p card.current_journey
# station3 = Station.new("Aldgate East", 5)
# station4 = Station.new("Liverpool Street", 9)
# card.tap_in(station3)
# card.tap_out(station4)
# p card.current_journey

p "---"
card.add_to_journey
p card.journey_history
# p card.complete?

p '---'
card.tap_out(station2)
# p card.journey_history
# p card.complete?
card.add_to_journey
p card.journey_history


