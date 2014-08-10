class Pomodoro < CDQManagedObject
  
  TODAY = -> { Time.new(Time.now.year, Time.now.month, Time.now.day, 0,0,0) }
  
  scope :today, where(:started_at).gt(TODAY.call)
  
  def self.current=(pomodoro)
    @current = pomodoro
  end
  
  def self.current
    @current
  end
  
  def complete?
    return false unless finished_at
    (finished_at - started_at) >= MainController::SECONDS_IN_25_MINS
  end

  def incomplete?
    !complete?
  end
  
  def finish
    self.finished_at = Time.now
    cdq.save
  end
  
end