require 'oystercard'
describe OysterCard do
  it 'has initial balance of 0' do
    expect(subject.balance).to eq 0
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

end 