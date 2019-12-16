class OysterCard
  MAX_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
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


end