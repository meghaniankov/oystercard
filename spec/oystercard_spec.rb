require 'oystercard'
describe OysterCard do
  let(:station) {double :station, :station_name => "Paddington", :zone => 1}
  let(:journey) { double :journey }
  let(:entry_station) { double :entry_station, :station_name => "Paddington", :zone => 1 }
  let(:exit_station) { double :exit_station, :station_name => "Kings Cross", :zone => 3 }

  it 'has initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'initializes with empty array for journey history' do
    expect(subject.journey_history).to eq []
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }


    it 'top_up of 5 increases balance by 5' do
      expect { subject.top_up(5) }.to change {subject.balance }.by(5)
    end 

    it 'top_up cannot exceed MAX_LIMIT' do
      message = "Top up is above maximum limit of #{OysterCard::MAX_LIMIT}"
      expect{ subject.top_up(OysterCard::MAX_LIMIT + 1) }.to raise_error message
    end
  end

  describe '#exceeds_limit' do
    it 'returns false if top_up amount is less than MAX_LIMIT' do
      expect(subject.exceeds_limit(OysterCard::MAX_LIMIT - 1)).to eq false
    end

    it 'returns true if top_up amount is more than MAX_LIMIT' do
      expect(subject.exceeds_limit(OysterCard::MAX_LIMIT + 1)).to eq true
    end

  end

  describe '#tap_in' do

    it 'raises and error if balance is below minimum fare' do
      expect { subject.tap_in(station) }.to raise_error "Balance below minimum fare of #{Journey::MIN_FARE}"
    end 

  end

  describe '#tap_out' do
    

    it 'decreases balance by MIN_FARE when tapping out' do
      subject.top_up(Journey::MIN_FARE)
      subject.tap_in(station)
      expect { subject.tap_out(station) }.to change {subject.balance }.by(-Journey::MIN_FARE)
    end
  
    it 'adds hash of entry and exit stations to journey history array' do
      allow(station).to receive(:station_name) { "Paddington" }
      allow(station).to receive(:zone) { 1 }
      subject.top_up(Journey::MIN_FARE)
      subject.tap_in(station)
      subject.tap_out(station)
      station_array = [station.station_name, station.zone]
      expect(subject.journey_history).to eq [{entry_station: station_array, exit_station: station_array}]

    end
  end


  describe '#insufficient_balance' do
    it 'returns true if balance is less than MIN_FARE' do
      subject.top_up(Journey::MIN_FARE - 1)
      expect(subject.insufficient_balance).to eq true 
    end

    it 'returns false if balance is greater than MIN_FARE' do
      subject.top_up(Journey::MIN_FARE + 1)
      expect(subject.insufficient_balance).to eq false 
    end
  end 

  describe '#journey_history' do
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    it 'initializes with empty array of journeys' do
      expect(subject.journey_history).to be_empty
    end

    it 'saves a journey hash inside journey_history' do
      subject.top_up(Journey::MIN_FARE + 1)
      subject.tap_in(station)
      subject.tap_out(station)
      expect(subject.journey_history.any? {|journey| journey[:entry_station] == ["Paddington", 1] }).to eq true
    end
  end

end 