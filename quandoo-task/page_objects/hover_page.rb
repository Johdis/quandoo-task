class HoverPage

  AVATAR = 'figure'
  HOVER_USERNAME = 'figcaption'

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
    @driver.navigate.to 'http://the-internet.herokuapp.com/hovers'
  end

  def close_browser()
    @driver.quit
  end

  def get_list_avatars
    return @driver.find_elements(:class, AVATAR)
  end

  def hover(element)
    @driver.action.move_to(element).perform
  end

  def get_username
    elements = @driver.find_elements(:class, HOVER_USERNAME)
    elements.each do |element|
      if element.displayed?
        return element.text
        break
      end
    end
  end
end
