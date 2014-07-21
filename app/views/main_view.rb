class MainView < UIView
  
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
    @timer_button ||= UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.styleId = 'timerButton'
      button.setTitle('Start Timer', forState: UIControlStateNormal)
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