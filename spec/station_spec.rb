describe Station do

  describe 'name' do
    it 'is created with a name' do
      station = Station.new("Kings Cross", 1)
      expect(station.name).to eq("Kings Cross")
    end
  end

  describe 'zone' do
    it 'is created with a zone' do
      station = Station.new("Kings Cross", 1)
      expect(station.zone).to eq(1)
    end
  end

end