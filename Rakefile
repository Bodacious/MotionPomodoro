# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

# Load a private Rakefile with sensitive keys etc.
begin
  load File.join(File.dirname(__FILE__), "PrivateRakefile")
# rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Motion Pomodoro'
  
  app.pixatefreestyle.framework = 'vendor/PixateFreestyle.framework'
  
  app.interface_orientations = [:portrait]
end
