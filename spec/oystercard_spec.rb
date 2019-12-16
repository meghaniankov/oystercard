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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts 5 from the balance' do
      subject.top_up(10)
      expect { subject.deduct(5) }.to change {subject.balance }.by(-5)
    end 
  end 


  describe '#tap_in' do
    it 'changes in_use from false to true' do
      subject.tap_in
      expect(subject.in_use).to eq true
    end
  end

  describe '#tap_out' do
    it 'changes in_use from true to false' do
      subject.tap_out
      expect(subject.in_use).to eq false
    end
  end

  describe '#journey?' do
    it 'returns true if in_use is true' do
      subject.tap_in
      expect(subject.journey?).to eq true
    end

    it 'returns false if in_use is false' do
      subject.tap_in
      subject.tap_out
      expect(subject.journey?).to eq false
    end
  end

end 