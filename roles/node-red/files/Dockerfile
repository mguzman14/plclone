FROM debian:stable-slim
RUN apt update && apt install -y nodejs npm
RUN npm install -g --unsafe-perm node-red
CMD ["node-red"]