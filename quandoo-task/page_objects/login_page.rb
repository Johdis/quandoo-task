class LoginPage

  @@username = 'tomsmith'
  @@password = 'SuperSecretPassword!'
  @@wrong_username = 'maxmustermann'
  @@wrong_password = 'UnvalidPassword3000'
  @@login_field = 'username'
  @@password_field = 'password'
  @@submit_button = 'radius'
  @@message_success = ".flash.success"
  @@message_failure = ".flash.error"

  def initialize
    browser = ENV['BROWSER']
    hub_ip = ENV['HUB_HOST']
    hub_port = ENV['PORT']

    hub_url = "http://#{hub_ip}:#{hub_port}/wd/hub"

    case browser
    when 'firefox'
      cap = Selenium::WebDriver::Remote::Capabilities.firefox()
    when 'chrome'
      cap = Selenium::WebDriver::Remote::Capabilities.chrome()
    else
      cap = Selenium::WebDriver::Remote::Capabilities.chrome()
    end

    @driver = Selenium::WebDriver.for(:remote, :url => hub_url, :desired_capabilities => cap)
    @driver.manage.window.size = Selenium::WebDriver::Dimension.new(1920, 1080)
    @driver.manage.timeouts.implicit_wait = 10
    @driver.navigate.to 'http://the-internet.herokuapp.com/login'
  end

  def close_browser()
    @driver.quit
  end

  def login_username
    @driver.find_element(:id, @@login_field).send_keys @@username
  end

  def login_password
    @driver.find_element(:id, @@password_field).send_keys @@password
  end

  def login_wrong_username
    @driver.find_element(:id, @@login_field).send_keys @@wrong_username
  end

  def login_wrong_password
    @driver.find_element(:id, @@password_field).send_keys @@wrong_password
  end

  def login_submit
    @driver.find_element(:class, @@submit_button).click
  end

  def login_check
    return @driver.find_element(:css, @@message_success)
  end

  def login_failure
#    @driver.save_screenshot('./screen.png')
    return @driver.find_element(:css, @@message_failure)
  end
  
end
