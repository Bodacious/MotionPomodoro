class TaskCell < UITableViewCell
  
  include ActsAsPomodoroParentView
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'taskCell'
    end
  end
  
  def configure_for_task(task)
    textLabel.text = task.name
    add_pomodoro_view(16 || task.pomodoros.count)
    puts "added #{task.pomodoros.count} Pomos to cell"
  end
  
  def prepareForReuse
    textLabel.text = ''    
    self.subviews.select { |sub| sub.is_a?(PomodoroView) }.each(&:removeFromSuperview)
  end
  
end