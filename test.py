from selenium import webdriver
from selenium.webdriver.common.keys import Keys

options = webdriver.ChromeOptions()
options.binary_location = './'

driver = webdriver.Chrome(options=options)
driver.get("https://www.python.org")
print(driver.title)