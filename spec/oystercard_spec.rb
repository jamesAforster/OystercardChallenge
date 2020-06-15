require './lib/oystercard.rb'

describe Oystercard do
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
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "£#{maximum_balance} top up limit exceeded!"
    end
  end

  describe '#deduct' do
    it "deducts a value" do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it "deducts money from the balance" do
      subject.top_up(10)
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  it "can touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end
end
