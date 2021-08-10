### STAGE 1: Build ###
FROM python AS build
RUN pip install Sphinx
RUN pip install sphinx-rtd-theme
USER root
RUN mkdir -p /usr/src/rtd
RUN chown root /usr/src/rtd
WORKDIR /usr/src/rtd
COPY . .
RUN make html

### Stage 2: Host ###
FROM node:latest
ENV HTTP_SERVER_VERSION 0.9.0
ENV PUBLIC_FOLDER /opt/www
RUN mkdir -p $PUBLIC_FOLDER
RUN npm install -g http-server@0.9.0

COPY --from=build /usr/src/rtd/build $PUBLIC_FOLDER

CMD http-server $PUBLIC_FOLDER/html
EXPOSE 8080
