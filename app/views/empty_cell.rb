class EmptyCell < UITableViewCell
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'emptyCell'
      addSubview(empty_label)
    end
  end
  
  
  def empty_label
    @empty_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleClass = 'emptyLabel'
      label.text = "Click '+' to add your first task"
    end
  end
  
end