class AppDelegate
  
  include CDQ  
    
  attr_reader :window, :main_controller, :nav_controller

  def application(application, didFinishLaunchingWithOptions:launchOptions)    
    @window          = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @main_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    @nav_controller  = UINavigationController.alloc.
      initWithRootViewController(main_controller)
      
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
    # PixateFreestyle.updateStylesForAllViews
    PixateFreestyle.refreshStylesWithOrientationChange = true
  end
end
