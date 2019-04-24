FROM heroku/heroku:18

# Sets the working directory (Heroku crashes without it)
WORKDIR /

# Copy Sinatra app into container
ADD myapp.rb myapp.rb

# heroku exec support 
# https://devcenter.heroku.com/articles/exec#using-with-docker
ADD ./.profile.d /app/.profile.d
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

ARG STAGING_CONFIG_VAR

# Print config vars
RUN env
