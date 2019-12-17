require 'oystercard'
describe OysterCard do
  let(:station) {double :station}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

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
      expect { subject.tap_in(station) }.to raise_error "Balance below minimum fare of #{OysterCard::MIN_FARE}"
    end 
    
    it 'sets the entry station' do
      subject.top_up(OysterCard::MIN_FARE)
      subject.tap_in(station)
      expect(subject.entry_station).to eq station
    end 


  end

  describe '#tap_out' do
    

    it 'decreases balance by MIN_FARE when tapping out' do
      subject.top_up(OysterCard::MIN_FARE)
      subject.tap_in(station)
      expect { subject.tap_out(station) }.to change {subject.balance }.by(-OysterCard::MIN_FARE)
    end

    it 'sets entry station to nil' do
      subject.top_up(OysterCard::MIN_FARE)
      subject.tap_in(station)
      subject.tap_out(station) 
      expect(subject.entry_station).to eq nil
    end 

    it 'sets exit station' do
      subject.top_up(OysterCard::MIN_FARE)
      subject.tap_in(station)
      subject.tap_out(station)
      expect(subject.exit_station).to eq station
    end

    it 'adds hash of entry and exit stations to journey history array' do
      subject.top_up(OysterCard::MIN_FARE)
      subject.tap_in(entry_station)
      subject.tap_out(exit_station)
      expect(subject.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end
  end

  describe '#journey?' do
    before { subject.top_up(OysterCard::MIN_FARE) }

    it 'returns true if in_use is true' do
      subject.tap_in(station)
      expect(subject.journey?).to eq true
    end

    it 'returns false if not in use' do
      subject.tap_in(station)
      subject.tap_out(station)
      expect(subject.journey?).to eq false
    end
  end

  describe '#insufficient_balance' do
    it 'returns true if balance is less than MIN_FARE' do
      subject.top_up(OysterCard::MIN_FARE - 1)
      expect(subject.insufficient_balance).to eq true 
    end

    it 'returns false if balance is greater than MIN_FARE' do
      subject.top_up(OysterCard::MIN_FARE + 1)
      expect(subject.insufficient_balance).to eq false 
    end
  end 

end 