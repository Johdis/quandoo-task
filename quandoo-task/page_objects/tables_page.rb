class TablesPage

  TABLE_HEADER_DEFAULT = "#table2 .header"
  TABLE_HEADER_ASCENDING = "#table2 .header.headerSortDown"
  TABLE_HEADER_DESCENDING = "#table2 .header.headerSortUp"
  LASTNAMES = "#table2 td.last-name"

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
    @driver.navigate.to 'http://the-internet.herokuapp.com/tables'
  end

  def close_browser()
    @driver.quit
  end

  def click_header_default
    @driver.find_element(:css, TABLE_HEADER_DEFAULT).click
  end

  def click_header_ascending
    @driver.find_element(:css, TABLE_HEADER_ASCENDING).click
  end

  def get_last_names
    names = []
    elements = @driver.find_elements(:css, LASTNAMES)
    elements.each do |element|
      names.push(element.text)
    end
    return names
  end

end
