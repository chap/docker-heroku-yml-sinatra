FROM ubuntu:xenial

# Create app directory
# WORKDIR /usr/src/app
WORKDIR /

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# COPY package*.json ./
# COPY .npmrc ./
# COPY .netrc /root/.netrc

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

# RUN npm run build-isomorphic-utils
# RUN npm run build-query-builder
# RUN npm run build-monster
# RUN npm run build-data-studio
# RUN npm run build-analytics-portal
# RUN bash scripts/copy-assets.sh
# RUN bash scripts/hack-dependencies.sh
# RUN bash scripts/purge-sources.sh
# RUN Rscript init.R
# RUN rm -rf .git
# RUN rm -rf .nyc_output
# RUN rm -rf test
# RUN rm /root/.netrc

# EXPOSE 1337
# CMD [ "pm2-runtime", "app.js" ]


# Sets the working directory (Heroku crashes without it)
WORKDIR /


# Copy Sinatra app into container
ADD myapp.rb myapp.rb

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

CMD [ "ruby", "app.rb", "-p", "$PORT" ]
