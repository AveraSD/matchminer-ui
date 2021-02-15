# pull base node image.
FROM node:8-onbuild

 # Just in case PhantomJS fails, or you had to run a docker system prune -a
RUN apt-get install libfontconfig

 # install phantomjs globally
RUN npm install -g phantomjs-prebuilt --ignore-scripts
ENV PHANTOMJS_BIN "/usr/local/bin/phantomjs"

 # install dependencies globally and with package.json
RUN npm install -g bower gulp
RUN npm install

 # copy all app data to /data
COPY . /data

 # run bower install with sudo
RUN bower install --config.interactive=false  --allow-root

 # run the gulp tests
#RUN gulp test

 # define working directory.
#WORKDIR /data

 # copy the data
#COPY dist /var/www/apache-flask/api/static

# add files to context
COPY app /app
COPY gulp /gulp
COPY gulpfile.js /gulpfile.js
COPY properties /properties
COPY certificates /certificates

# serve it
RUN gulp serve

# modifications based on: https://github.com/dfci/matchminer-ui/issues/5#issuecomment-450679050
