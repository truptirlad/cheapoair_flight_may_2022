require 'watir'

Before do |scenario|
  DataMagic.load_for_scenario(scenario)
  @browser = Watir::Browser.new :'chrome'
  @browser.driver.manage.window.maximize
end


After do
  @browser.close
end

#After do |scenario|
# if scenario.failed?
#   @browser.screenshot("failed.jpg")
#  end

#end
After do

end