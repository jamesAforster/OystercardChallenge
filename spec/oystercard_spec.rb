require './lib/oystercard.rb'

describe Oystercard do
  describe '#balance' do
    it 'checks if there is a balance' do
      expect(subject.balance).to eq(0)
    end
  end
end