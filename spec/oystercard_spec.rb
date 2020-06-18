require './lib/oystercard.rb'

describe Oystercard do
  MAXIMUM_BALANCE = 90
  let(:station) { double "Kings Cross" }

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
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_in' do

    it "can touch in" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it "raises an error when minimum balance is less than £1" do
      card = Oystercard.new
      expect { card.touch_in }.to raise_error("Insufficient funds")
    end

    it "records the last station touched in at" do
      station = double("Kings Cross")
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    it "can touch out" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it "deducts the balance after touched out" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.balance).to eq(9)
    end

    it "will set entry_station to nil" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
    end

    it "records the exit station" do
      subject.top_up(10)
      subject.touch_out(station)
      expect(subject.exit_station).to eq(station)
    end

    # it "will add the entry station and exit station as a journey object" do
    #   station = Station.new("Kings Cross", 1)
    #   station2 = Station.new("Walthamstow", 4)
    #   journey = Journey.new(station, station2)
    #   subject.top_up(10)
    #   subject.touch_in(station)
    #   subject.touch_out(station2)
    #   expect(subject.journey_history).to include(journey)
    # end
  end

  describe '#journey_history' do

    it "checks card has empty journey history by default" do
      card = Oystercard.new
      expect(card.journey_history).to eq([])
    end

    it "lists the journey history" do
      exit_station = "Camden"
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journey_history[0][:entry_station]).to eq(station)
    end

    it "lists one journey" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.journey_history.length).to eq(1)
    end

  end
end
