# Testing a Chrome Extension with Selenium in Python

This guide will walk you through the steps necessary to test a locally-built Chrome extension using Selenium in Python with Docker.

## Prerequisites

- Docker (latest version recommended)
- Python 3.x
- Git

## Clone the Project

```
git clone https://github.com/turbo-src/selenium-chrome-extension-testing.git
cd selenium-chrome-extension-testing
```

This command clones the project from GitHub and navigates into the project directory.

## Usage

```
docker-compose up --build -d
```

This command builds the images (if they are not already built) and starts the services defined in docker-compose.yml in the background.

```
docker-compose exec web python test_selenium.py
```

Executes your test script in the Python container.

## Docker Cleanup (Optional)

### Stop and Remove Docker Compose Services

```
docker-compose down
```

### Remove Docker Image (Optional)

```
docker rmi selenium/standalone-chrome:latest
```

This command removes the Docker image named `selenium/standalone-chrome:latest`.

## test_selenium.py

Here is a non-extension based test to help you orient yourself.

```python
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

driver = webdriver.Remote("http://selenium:4444/wd/hub", DesiredCapabilities.CHROME)

driver.get("https://www.python.org")
print(driver.title)
```

Note: In the docker-compose.yml, we defined a service named `selenium`, so in the Python Selenium script, we use `http://selenium:4444/wd/hub` as the Selenium server URL.

## Testing the Extension

Here are the steps you need to follow to test your Chrome extension.

1. **Load the Chrome Extension Locally**

Begin by loading your locally built extension into Chrome. You can do this by opening Chrome and navigating to 'chrome://extensions/'. Make sure that the "Developer mode" toggle in the top-right corner is enabled, then click "Load unpacked". From here, navigate to the directory containing your extension's files and select it.

2. **Find the Extension ID**

After your extension is loaded in Chrome, you'll see its unique ID on the 'chrome://extensions/' page. Take note of this ID.

3. **Identify the Page to be Tested**

Determine which page of your extension you wish to test. If you're uncertain, inspect your extension's source files. You'll likely be testing a popup or options page, such as 'popup.html' or 'options.html'.

4. **Initiate Selenium Script to Create a New WebDriver Instance with the Loaded Extension**

Here is how to instantiate a new WebDriver instance with your loaded extension using Python's selenium bindings:

```python
from selenium import webdriver

options = webdriver.ChromeOptions()
options.add_argument('load-extension=/path/to/extension/')

driver = webdriver.Chrome(options=options)
```

Replace `/path/to/extension/` with the path to your extension's directory in the above example.

5. **Navigate to the Extension's Page to be Tested**

With the WebDriver instance set up and the extension loaded, you can now navigate to the extension's page using its unique URL. The URL should follow this format: 'chrome-extension://UNIQUEID/PAGE.html'. You can do this with the 'get' method:

```python
driver.get('chrome-extension://UNIQUEID/PAGE.html')
```

Replace `UNIQUEID` with your extension's ID and `PAGE.html` with the page you want to test.

6. **Interact with Elements and Send Keystrokes**

You can use the 'find_element_by_' methods to locate webpage elements based on their attributes, such as ID, name, class name, or CSS selector. Then you can interact with these elements, for example by sending keystrokes or clicking on them.

To send keystrokes, you can use the 'send_keys' method:

```python
element = driver.find_element_by_id("element_id")
element.send_keys("Some text")
```

To click an element, you can use the 'click' method:

```python
element = driver.find_element_by_id("button_id")
element.click()
```