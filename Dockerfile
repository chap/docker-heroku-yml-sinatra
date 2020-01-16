FROM ruby:2.5.1-alpine

# Sets the working directory (Heroku crashes without it)
WORKDIR /

# Copy Sinatra app into container
ADD myapp.rb myapp.rb

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

ARG STAGING_CONFIG_VAR
ARG SOURCE_VERSION

RUN echo SOURCE_VERSION
RUN echo $SOURCE_VERSION

# Print config vars
RUN env

CMD ruby myapp.rb -p $PORT
