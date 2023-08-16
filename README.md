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

After running this command, the shell prompt will return to normal, indicating that the virtual environment is deactivated.

## Docker Cleanup (Optional)

### Stop and Remove Docker Container

To stop the Selenium server running in the Docker container:

```
docker stop $(docker ps -q -f ancestor=selenium/standalone-chrome:latest)
```

### Remove Docker Image (Optional)

```
docker rmi selenium/standalone-chrome:latest
```

This command removes the Docker image named `selenium/standalone-chrome:latest`.