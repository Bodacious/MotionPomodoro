class Time
  
  SECONDS_IN_25_MINS = RUBYMOTION_ENV == 'development' ? 10 : 1500
  
  def self.secs_in_25_mins
    SECONDS_IN_25_MINS
  end
    
end