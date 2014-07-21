class AppDelegate
    
  attr_reader :window, :main_controller, :nav_controller

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window          = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @main_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    @nav_controller  = UINavigationController.alloc.
      initWithRootViewController(main_controller)
      
    window.rootViewController = nav_controller
    window.makeKeyAndVisible
    setup_pixate
    true
  end
  
  private
  
  def setup_pixate
    PixateFreestyle.initializePixateFreestyle
    PXStylesheet.clearCache
    # PixateFreestyle.updateStylesForAllViews
    PixateFreestyle.refreshStylesWithOrientationChange = true
  end
end
