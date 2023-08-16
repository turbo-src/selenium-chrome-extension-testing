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

Executes your test script in the python container.

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
