FROM rcreasey/rpi-homebridge:base-latest

RUN npm install -g https://github.com/rcreasey/homebridge-garage-sentry.git --unsafe-perm
RUN npm install -g homebridge-nest --unsafe-perm
RUN apt-get update && apt-get install iputils-ping && apt-get clean
RUN npm install -g homebridge-broadlink-rm
