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
  end
end
