FROM node:8.16.0 AS builder

# Prepare the work directory

ENV HOME /home/deploy
RUN useradd -m deploy
WORKDIR $HOME

COPY package.json $HOME

#RUN chown -R deploy:deploy $HOME
#USER deploy

#RUN apt-get -y update && apt-get -y install git && apt-get clean
RUN npm install
RUN npm install -g gulp

FROM builder

ADD . $HOME
RUN gulp build

RUN chown -R deploy:deploy $HOME
USER deploy

EXPOSE 4000
#RUN gulp
CMD [ "gulp", "start" ]