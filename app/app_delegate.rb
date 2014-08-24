class AppDelegate
  
  include CDQ  
  
  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end
  
  def main_controller
    @main_controller ||= MainController.alloc.initWithNibName(nil, bundle: nil)
  end
  
  def nav_controller
    @nav_controller ||= UINavigationController.alloc.
      initWithRootViewController(main_controller)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    cdq.setup
    setup_pixate
    setup_UI_defaults
      
    window.rootViewController = nav_controller
    window.makeKeyAndVisible
    true
  end
  
  private
  
  def setup_UI_defaults
    text_atts = { UITextAttributeTextColor => UIColor.whiteColor }

    UIBarButtonItem.appearanceWhenContainedIn(UINavigationBar, nil).
      setTitleTextAttributes(text_atts, forState: UIControlStateNormal)
    
    nav_controller.navigationBar.titleTextAttributes = text_atts
    nav_controller.navigationBar.barTintColor        = UIColor.pomo_red_color
    nav_controller.navigationBar.tintColor           = UIColor.whiteColor
  end
  
  def setup_pixate
    PixateFreestyle.initializePixateFreestyle
    PXStylesheet.clearCache
    PixateFreestyle.refreshStylesWithOrientationChange = true
  end
  
end