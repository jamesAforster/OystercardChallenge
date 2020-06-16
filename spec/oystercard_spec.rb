require './lib/oystercard.rb'

describe Oystercard do
  MAXIMUM_BALANCE = 90

  describe '#initialize' do
    it "creates card with a maximum balance of £90" do
      expect(Oystercard.new.maximum_balance).to eq(90)
    end
  end

  describe '#balance' do
    it 'checks if there is a balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it "tops up the card with a value" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "can top up the balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "raises an error when maximum balance is exceeded" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up 1 }.to raise_error "£#{MAXIMUM_BALANCE} top up limit exceeded!"
    end
  end

  describe '#deduct' do
    it "deducts money from the balance" do
      subject.top_up(10)
      expect{ subject.send(:deduct, 1) }.to change{ subject.balance }.by -1
    end
  end

  describe '#in_journey?' do
    it "is initially not in a journey" do
      expect(subject.in_journey).to eq(false)
    end
  end

  describe '#touch_in' do
    it "can touch in" do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey).to eq(true)
    end

    it "raises an error when minimum balance is less than £1" do
      card = Oystercard.new
      expect { card.touch_in }.to raise_error("Insufficient funds")
    end
  end

  describe '#touch_out' do
    it "can touch out" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq(false)
    end

    it "deducts the balance after touched out" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.balance).to eq(9)
    end
  end
end
