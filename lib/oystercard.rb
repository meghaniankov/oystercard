class OysterCard
  MAX_LIMIT = 90
  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Top up is above maximum limit of #{MAX_LIMIT}" if exceeds_limit(amount)
    @balance += amount 
  end 
    
  def exceeds_limit(amount)
    amount > MAX_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end 

  def tap_in
    @in_use = true
  end

  def tap_out
    @in_use = false
  end

  def journey?
    @in_use
  end
end