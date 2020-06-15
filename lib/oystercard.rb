class Oystercard
  attr_reader :balance #:in_journey
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "£#{MAXIMUM_BALANCE} top up limit exceeded!" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    false
    @in_journey
  end

  def touch_in
  #  journey = @in_journey.new(true)
  #  journey
  end
end
