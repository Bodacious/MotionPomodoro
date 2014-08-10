class TaskCell < UITableViewCell
  
  include ActsAsPomodoroParentView
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'taskCell'
    end
  end
  
  def configure_for_task(task)
    textLabel.text = task.name
    add_pomodoro_view(task.pomodoros.count)
  end
  
  def prepareForReuse
    super
    textLabel.text = ''    
    self.subviews.select { |sub| sub.is_a?(PomodoroView) }.each(&:removeFromSuperview)
  end
  
end