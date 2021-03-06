class PomodoroView < UIView
  
  def initWithFrame(frame)
    super.tap do
      self.styleClass = 'pomodoroView'
    end
  end
  
  def drawRect(rect)
    context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, UIColor.pomo_red_color.CGColor)
    CGContextFillEllipseInRect(context, rect)
  end
  
end