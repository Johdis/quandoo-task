class LoginPage

  USERNAME = 'tomsmith'
  PASSWORD = 'SuperSecretPassword!'
  WRONG_USERNAME = 'maxmustermann'
  WRONG_USERPASSWORD = 'UnvalidPassword3000'
  LOGIN_FIELD = 'username'
  PASSWORD_FIELD = 'password'
  SUBMIT_BUTTON = 'radius'
  MESSAGE_SUCCESS = ".flash.success"
  MESSAGE_FAILURE = ".flash.error"

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
    @driver.find_element(:id, LOGIN_FIELD).send_keys USERNAME
  end

  def login_password
    @driver.find_element(:id, PASSWORD_FIELD).send_keys PASSWORD
  end

  def login_wrong_username
    @driver.find_element(:id, LOGIN_FIELD).send_keys WRONG_USERNAME
  end

  def login_wrong_password
    @driver.find_element(:id, PASSWORD_FIELD).send_keys WRONG_USERPASSWORD
  end

  def login_submit
    @driver.find_element(:class, SUBMIT_BUTTON).click
  end

  def login_check
    return @driver.find_element(:css, MESSAGE_SUCCESS)
  end

  def login_failure
    return @driver.find_element(:css, MESSAGE_FAILURE)
  end

end
