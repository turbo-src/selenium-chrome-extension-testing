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

## Docker Setup

### Step 1: Create a docker-compose.yml File

Create a docker-compose.yml file in the project root with the following content:

```yaml
version: '3'
services:
  web:
    build: .
    volumes:
      - .:/app
    depends_on:
      - selenium

  selenium:
    image: selenium/standalone-chrome:latest
    ports:
      - "4444:4444"
      - "7900:7900"
```

This configuration creates two services:

- `web`: This is the application container where your Python Selenium tests will run.
- `selenium`: This is the Selenium standalone Chrome server.

### Step 2: Create a Dockerfile for the Python Environment

Create a Dockerfile in the project root with the following content:

```
FROM python:3.x

WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app/
```

This Dockerfile sets up a Python environment, installs the necessary dependencies, and copies your code into the container.

### Step 3: Build and Run the Docker Compose Services

```
docker-compose up --build
```

This command builds the images (if they are not already built) and starts the services defined in docker-compose.yml.

### Step 4: Execute Your Test Script in the Python Container

```
docker-compose exec web python test_selenium.py
```

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
