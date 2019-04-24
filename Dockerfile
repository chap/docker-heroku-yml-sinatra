FROM heroku/heroku:18

# Sets the working directory (Heroku crashes without it)
WORKDIR /

# Copy Sinatra app into container
ADD myapp.rb myapp.rb

# heroku exec file
ADD ./.profile.d .profile.d

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

ARG STAGING_CONFIG_VAR

# Print config vars
RUN env
