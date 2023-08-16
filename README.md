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

## Setting Up a Virtual Environment

### Step 1: Create a Virtual Environment

```
python -m venv venv
```

### Step 2: Activate the Virtual Environment

```
source venv/bin/activate
```

After running this command, your shell prompt should change to show the name of the activated environment.

### Step 3: Install Python Dependencies

```
pip install -r requirements.txt
```

This command installs the required Python packages specified in `requirements.txt` into the virtual environment.

## Testing the Extension

Follow these steps to test your Chrome extension:

1. **Load the Chrome Extension Locally**
   - Begin by loading your locally built extension into Chrome. Navigate to 'chrome://extensions/'. Ensure the "Developer mode" toggle in the top-right corner is enabled, then click "Load unpacked". From here, navigate to the directory containing your extension's files and select it.

2. **Find the Extension ID**
   - After your extension is loaded in Chrome, note its unique ID on the 'chrome://extensions/' page.

3. **Identify the Page to be Tested**
   - Determine which page of your extension you wish to test, such as 'popup.html' or 'options.html'.

4. **Initiate Selenium Script to Create a New WebDriver Instance with the Loaded Extension**

```
from selenium import webdriver

options = webdriver.ChromeOptions()
options.add_argument('load-extension=/path/to/extension/')

driver = webdriver.Chrome(options=options)
```

Replace `/path/to/extension/` with the path to your extension's directory.

5. **Navigate to the Extension's Page to be Tested**

```
driver.get('chrome-extension://UNIQUEID/PAGE.html')
```

Replace `UNIQUEID` with your extension's ID and `PAGE.html` with the page you want to test.

6. **Interact with Elements and Send Keystrokes**

```
element = driver.find_element_by_id("element_id")
element.send_keys("Some text")
```

```
element = driver.find_element_by_id("button_id")
element.click()
```

7. **Perform Your Tests**
   - Now you can interact with and test your extension's page as you would a regular webpage.

## Docker Setup

### Step 1: Start the Selenium Server

```
docker run -d -p 4444:4444 -p 7900:7900 --shm-size="2g" selenium/standalone-chrome:latest
```

This command starts a new container with the Selenium standalone Chrome server.

### Step 2: Run Your Test Script

With the Selenium server running in Docker and your Python virtual environment activated, you can now run your test script:

```
python test_selenium.py
```

## Deactivating the Virtual Environment

When you are done, you can deactivate the virtual environment:

```
deactivate
```

After running this command, the shell prompt will return to normal.

## Docker Cleanup (Optional)

### Stop and Remove Docker Container

```
docker stop $(docker ps -q -f ancestor=selenium/standalone-chrome:latest)
```

### Remove Docker Image (Optional)

```
docker rmi selenium/standalone-chrome:latest
```

This command removes the Docker image named `selenium/standalone-chrome:latest`.

### test_selenium.py

Here is a non-extension based test to help you orient yourself.

```
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

driver = webdriver.Remote("http://localhost:4444/wd/hub", DesiredCapabilities.CHROME)

driver.get("https://www.python.org")
print(driver.title)
```