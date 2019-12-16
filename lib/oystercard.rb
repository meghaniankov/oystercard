class OysterCard
  MAX_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Top up is above maximum limit of #{MAX_LIMIT}" if exceeds_limit(amount)
    @balance += amount 
  end 

  def tap_in
    fail "Balance below minimum fare of #{MIN_FARE}" if insufficient_balance 
    @in_use = true
  end

  def tap_out
    deduct(MIN_FARE)
    @in_use = false
  end

  def journey?
    @in_use
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