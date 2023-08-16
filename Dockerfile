# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the maintainer label
LABEL maintainer=""

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y wget unzip gnupg libglib2.0-0 && \
    apt-get clean && \
    apt-get install -y \
    libnss3 \
    libnss3-tools \
    libnss3-dev \
    libnspr4 \
    libnspr4-dev \
    libxcb1 \
    && rm -rf /var/lib/apt/lists/*


# Install specific version of Google Chrome
RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5845.96/linux64/chrome-linux64.zip && \
    unzip chrome-linux64.zip && \
    mkdir -p /opt/google/chrome && \
    mv chrome-linux64 /opt/google/chrome && \
    ln -s /opt/google/chrome/chrome /usr/bin/google-chrome

# Install compatible ChromeDriver
RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5845.96/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip && \
    mv chromedriver-linux64/chromedriver /usr/bin/chromedriver && \
    chown root:root /usr/bin/chromedriver && \
    chmod +x /usr/bin/chromedriver

# Set the working directory in the Docker container to /app
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app/
