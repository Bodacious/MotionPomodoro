class TaskCell < UITableViewCell
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'taskCell'
    end
  end
  
end