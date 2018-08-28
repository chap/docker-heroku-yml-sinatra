FROM ruby:2.5.1-alpine

# Sets the working directory (Heroku crashes without it)
WORKDIR /

# Copy Sinatra app into container
ADD myapp.rb myapp.rb

# Install Sinatra gem
# bump
RUN gem install sinatra --no-ri --no-rdoc

# Print config vars
RUN env
