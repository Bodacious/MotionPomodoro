class UIColor

  def self.pomo_grey_color
    @pomo_grey_color ||= UIColor.colorWithRed(0.5, green: 0.5, blue: 0.5, alpha: 1.0)
  end

  
  def self.pomo_green_color
    @pomo_green_color ||= UIColor.colorWithRed(0.0, green: 0.502, blue: 0.0, alpha: 1.0)
  end
  
  def self.pomo_red_color
    @pomo_red_color ||= UIColor.colorWithRed(0.5, green: 0.0, blue: 0.0, alpha: 0.0)
  end
  
  def self.print_rgba_for_color(color)
    red   = Pointer.new(:float)
    green = Pointer.new(:float)
    blue  = Pointer.new(:float)
    alpha = Pointer.new(:float)
    
    color.getRed(red, green: green, blue: blue, alpha: alpha)
    puts "red: #{red.value}, green: #{green.value}, blue: #{blue.value}"
  end
  

  def self.new_from_two_colors(color_1, color_2, options = {})
    prop  = options[:proportion] || 0.5

    color_1_red   = Pointer.new(:float)
    color_1_green = Pointer.new(:float)
    color_1_blue  = Pointer.new(:float)
    color_1_alpha = Pointer.new(:float)
    
    color_1.getRed(color_1_red, green: color_1_green, blue: color_1_blue, 
      alpha: color_1_alpha)
    
    color_2_red   = Pointer.new(:float)
    color_2_green = Pointer.new(:float)
    color_2_blue  = Pointer.new(:float)
    color_2_alpha = Pointer.new(:float)

    color_2.getRed(color_2_red, green: color_2_green, blue: color_2_blue, 
      alpha: color_2_alpha)
  
    new_red   = color_1_red.value   + (color_2_red.value   - color_1_red.value)   * prop
    new_green = color_1_green.value + (color_2_green.value - color_1_green.value) * prop
    new_blue  = color_1_blue.value  + (color_2_blue.value  - color_1_blue.value)  * prop
    
    # Assuming alpha is constant 1.0
    UIColor.colorWithRed(new_red, green: new_green, blue: new_blue, alpha: 1.0)
  end
  
end