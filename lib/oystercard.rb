require_relative 'station'

class Oystercard
  attr_reader :balance, :maximum_balance, :entry_station, :exit_station, :journey_history
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @maximum_balance = MAXIMUM_BALANCE
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "£#{MAXIMUM_BALANCE} top up limit exceeded!" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    if @entry_station == nil
      false
    else
      true
    end
  end

  def touch_in(station = nil)
    fail "Insufficient funds" if @balance < 1
    @entry_station = station
  end

  def touch_out(station = nil)
    @exit_station = station
    deduct(1)
    @journey_history << { :entry_station => @entry_station, :exit_station => @exit_station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
