class Journey
  attr_reader :entry_station, :complete
  PENALTY = 6
  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def finish
    @complete = true # deleted method complete. set to true if journey is finished
  end

  def fare
    if @entry_station == nil 
      PENALTY
    elsif @complete == false
      PENALTY
    end
  end



end