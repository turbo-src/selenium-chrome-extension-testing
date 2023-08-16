from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

driver = webdriver.Remote("http://localhost:4444/wd/hub", DesiredCapabilities.CHROME)

driver.get("https://www.python.org")
print(driver.title)
