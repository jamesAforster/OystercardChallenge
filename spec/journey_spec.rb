require './lib/journey'
require './lib/station'

describe Journey do
  let(:journey) { Journey.new }
  describe '#initialize' do
    # it 'will initialize with a entry station and a exit station' do
    # entry_station = Station.new("Kings Cross", 1)
    # exit_station = Station.new("Walthamstow", 4)
    # journey = Journey.new(entry_station, exit_station)
    # expect(journey.entry_station).to eq(entry_station)
    # expect(journey.exit_station).to eq(exit_station)
    # end

    it 'is initialized with an optional entry station' do
      journey = Journey.new
      expect(journey.entry_station).to eq(nil)
    end

  end

  describe '#finish' do
    it 'responds to the finish method' do
      expect(journey).to respond_to(:finish)
    end
  end

  describe '#fare' do
    it 'responds to the fare method' do
      expect(journey).to respond_to(:fare)
    end
  end

  describe '#complete?' do
    it 'responds to the complete? method' do
      expect(journey).to respond_to(:complete)
    end

    it 'gives false if journey not complete' do
      expect(journey.complete).to eq (false)
    end

    it 'give true if journey complete' do
      journey.finish("London Bridge")
      expect(journey.complete).to eq (true)
    end
  end

  describe '#fare' do
    it 'charges penalty when not touched in' do
    journey.finish("London Bridge")
    expect(journey.fare).to eq Journey::PENALTY
    end

     it 'charges penalty when not touched out' do
     journey = Journey.new("Camden")
     expect(journey.fare).to eq Journey::PENALTY 
     end

     it 'charge the fare of 1 when touched in and out' do
      journey = Journey.new("Camden")
      journey.finish("London Bridge")
      expect(journey.fare).to eq (1)
     end
  end


end