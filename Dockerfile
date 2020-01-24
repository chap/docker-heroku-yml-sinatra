FROM ubuntu:xenial

# Create app directory
# WORKDIR /usr/src/app
WORKDIR /

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
RUN touch package123
RUN touch package1234
RUN touch package1235
RUN touch package12356
RUN touch package123567
RUN touch package123568
RUN touch package123569
RUN touch package1235610
RUN touch package1235611
RUN touch package1235612
RUN touch package1235613
RUN touch package1235614
RUN touch package1235615
RUN touch package1235616
RUN touch package1235617
RUN touch package1235618
RUN touch package1235619
RUN touch package1235620

RUN apt-get update && apt-get install -y curl wget
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list
# for latest R version
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get install -y vim nodejs build-essential git gzip locales r-base python3-dev python3-pip unixodbc unixodbc-dev postgresql-client-10 ruby

# https://serverfault.com/questions/662034/how-do-i-resolve-this-locale-issue
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN DEBIAN_FRONTEND=noninteractive locale-gen

RUN pip3 install --upgrade pip
RUN pip3 install azure-mgmt-datafactory==0.8.0 azure-storage==0.36.0

RUN npm install -g n@3.0.2 pm2@3.5.0
RUN n 12.13.0
RUN npm install -g npm@6.12.0
RUN npm install --only=production
# RUN cd node_modules/tedious && npm i babel-runtime@^6.26.0 && cd ../..

# Bundle app source
COPY . .

RUN touch build-isomorphic-utils
RUN touch build-query-builder
RUN touch build-monster
RUN touch build-data-studio
RUN touch build-analytics-portal
RUN touchcopy-assets.sh
RUN touchhack-dependencies.sh
RUN touchpurge-sources.sh
RUN touch init.R
RUN touch .git
RUN touch .nyc_output
RUN touch test
RUN touch.netrc

# EXPOSE 1337
# CMD [ "pm2-runtime", "app.js" ]


# Sets the working directory (Heroku crashes without it)
WORKDIR /


# Copy Sinatra app into container
ADD myapp.rb myapp.rb

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

CMD [ "ruby", "app.rb", "-p", "$PORT" ]
