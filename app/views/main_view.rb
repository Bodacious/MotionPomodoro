class MainView < UIView
  
  include ActsAsPomodoroParentView
  
  TIMER_BUTTON_LABEL_NORMAL_TITLE = 'Start Timer'
  
  TIMER_BUTTON_LABEL_SELECTED_TITLE = "Interrupt!"  
  
  def initWithFrame(frame)
    super.tap do
      self.styleId = 'mainView'
      addSubview(timer_label)
      addSubview(timer_button)
      addSubview(task_label)
      addSubview(current_task_label)
    end
  end
  
  # Properties
  def timer_label
    @timer_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'timerLabel'
      label.text = '00:00'
      label.textColor = UIColor.pomo_grey_color
    end
  end
  
  def timer_button
    @timer_button ||= TimerButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.styleId    = 'timerButton'
      button.setTitle(TIMER_BUTTON_LABEL_NORMAL_TITLE, forState: UIControlStateNormal)
      button.setTitle(TIMER_BUTTON_LABEL_SELECTED_TITLE, forState: UIControlStateSelected)
    end
  end
  
  def task_label
    @task_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'taskLabel'
      label.text = 'n/a'
    end
  end
  
  def current_task_label
    @current_task_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'currentTaskLabel'
      label.text = 'Current task:'
    end
  end
  
end