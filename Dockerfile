
# Build process:
# cd dirContainingDockerfile
# docker build -t bkco/docker-nightwatch-xvfb .

FROM java:8-jre

## Node.js setup
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs

## Chrome w/xvfb
# From https://github.com/dockerfile/chrome/blob/master/Dockerfile
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable xvfb && \
  rm -rf /var/lib/apt/lists/*

# Fix for the issue with Selenium, as described here:
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

## Nightwatch
RUN npm install -g nightwatch