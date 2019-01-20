require 'bundler/setup'
require 'selenium-webdriver'
require 'minitest/autorun'

class TestLogin < Minitest::Test

  def setup
    browser = ENV['BROWSER']
    hub_ip = ENV['HUB_HOST']
    hub_port = ENV['PORT']

    hub_url = "http://#{hub_ip}:#{hub_port}/wd/hub"
    puts hub_url

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
  end

  def teardown
    @driver.quit
  end

  def test_page_login
    @driver.get 'http://the-internet.herokuapp.com/login'
    @driver.find_element(:css, "#username_alex")
  end
end
