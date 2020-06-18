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
      expect(journey).to respond_to(:complete?)
    end
  end
end