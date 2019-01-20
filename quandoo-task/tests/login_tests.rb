require 'bundler/setup'
require 'selenium-webdriver'
require 'minitest/autorun'
require_relative '../page_objects/login_page.rb'
require_relative '../page_objects/hover_page.rb'

class TestLogin < Minitest::Test

  @@wait = Selenium::WebDriver::Wait.new(:timeout => 10)
=begin
  def test_login_success
    browser = LoginPage.new
    browser.login_username
    browser.login_password
    browser.login_submit
    @@wait.until {browser.login_check}
    assert (browser.login_check).displayed?
    browser.close_browser
  end

  def test_login_failure_1
    browser = LoginPage.new
    browser.login_wrong_username
    browser.login_password
    browser.login_submit
    @@wait.until {browser.login_failure}
    assert (browser.login_failure).displayed?
    assert (browser.login_failure.text.include? 'Your username is invalid!')
    browser.close_browser
  end

  def test_login_failure_2
    browser = LoginPage.new
    browser.login_username
    browser.login_wrong_password
    browser.login_submit
    @@wait.until {browser.login_failure}
    assert (browser.login_failure).displayed?
    assert (browser.login_failure.text.include? 'Your password is invalid!')
    browser.close_browser
  end
=end
  def test_hover
    counter = 1
    browser = HoverPage.new
    browser.get_list_avatars.each do |avatar|
      browser.hover(avatar)
      puts "expected: #{browser.get_username.text}"
      puts "name: user#{counter}"
      assert (browser.get_username.text.include? "name: user#{counter}")
      counter += 1
    end
    browser.close_browser
  end
end
