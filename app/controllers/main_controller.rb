class MainController < UIViewController
  
  SECONDS_IN_25_MINS = RUBYMOTION_ENV == 'development' ? 5 : 1500
  
  attr_accessor :pomodoro_timer, :timer_count
    
  # ==================
  # = View Lifecycle =
  # ==================
    
  def loadView
    self.view = MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end
  
  def viewDidLoad
    super
    self.title = "Pomo-Todo"
    self.navigationItem.rightBarButtonItem = tasks_button
    timer_button.addTarget(self, action: 'timer_button_tapped:', 
      forControlEvents: UIControlEventTouchUpInside)
    Pomodoro.today.each do |pomodoro|
      view.add_pomodoro_view if pomodoro.complete?
    end      
  end
  
  def viewDidAppear(animated)
    super
    task_label.text = Task.current ? Task.current.name : MainView::TASK_LABEL_DEFAULT_TEXT
  end
  
  # ==============
  # = Properties =
  # ==============
    
  def timer_label
    view.timer_label
  end
  
  def timer_button
    view.timer_button
  end
  
  def task_label
    view.task_label
  end
  
  def tasks_button
    @tasks_button ||= UIBarButtonItem.alloc.initWithImage(tasks_image, 
      style: UIBarButtonItemStylePlain, target: self, action: 'tasks_button_tapped:')
  end
  
  def tasks_image
    @tasks_image ||= UIImage.imageNamed('todo.png')
  end
  
  def alert_view
    @alert_view ||= UIAlertView.alloc.initWithTitle("Pomodoro Complete!", 
      message: "Time to take a short break.", delegate: self, 
      cancelButtonTitle: "OK", otherButtonTitles: nil)
  end
  
  # ===========
  # = Actions =
  # ===========
    
  def tasks_button_tapped(sender)
    tasks_controller = TasksController.alloc.initWithNibName(nil, bundle: nil)
    navigationController.pushViewController(tasks_controller, animated: true)
  end
  
  def timer_button_tapped(sender)
    if timer_active?
      Pomodoro.current.finish
      Pomodoro.current = nil
      timer_button.selected = false
      pomodoro_timer.invalidate
      self.timer_count = 0
      
      timer_label.textColor = UIColor.pomo_grey_color      
      update_timer_label
    else
      Pomodoro.current = Pomodoro.create(started_at: Time.now, task: Task.current)
      cdq.save      
      timer_button.selected = true
      timer_label.textColor = UIColor.pomo_green_color
      self.timer_count = SECONDS_IN_25_MINS
      # Update the label immediately, so there's no delay
      update_timer_label
      self.pomodoro_timer = NSTimer.timerWithTimeInterval(1, target: self, 
        selector: 'decrement_timer:', userInfo: nil, repeats: true)
      NSRunLoop.currentRunLoop.addTimer(pomodoro_timer, forMode: NSDefaultRunLoopMode)
    end
  end
  
  # =======================
  # = UIAlertViewDelegate =
  # =======================
  
  def alertView(alertView, didDismissWithButtonIndex: button_index)
    view.add_pomodoro_view
    Pomodoro.current.finish 
    Pomodoro.current = nil
    
    timer_button.selected = false    
  end
  
  private
  
  
  def timer_active?
    pomodoro_timer && pomodoro_timer.valid?
  end
    
  def decrement_timer(sender)
    self.timer_count -= 1
    update_timer_label
    if timer_count <= 0
      pomodoro_timer.invalidate      
      alert_view.show
    end
  end
  
  def update_timer_label
    if timer_count % 10 == 0
      timer_label.textColor = color_for_timer_count
    end
    timer_label.text = timer_text_value_from_timer_count
  end
  
  def color_for_timer_count
    if timer_count && timer_count > 0
      proportion = Rational(timer_count, SECONDS_IN_25_MINS).to_f.round(2)
      color = UIColor.new_from_two_colors(UIColor.pomo_red_color, 
        UIColor.pomo_green_color, proportion: proportion)
    else
      UIColor.pomo_grey_color
    end
  end
  
  def timer_text_value_from_timer_count
    if timer_count && timer_count > 0
      mins = timer_count / 60
      secs = timer_count % 60
    else
      mins = '00'
      secs = '00'
    end
    "%02d:%02d" % [mins, secs]
  end
  
  def setup_timer_button(to_active)
    if to_active
      timer_button.highlighted = true
    else
      timer_button.highlighted = false
    end
  end
  
end