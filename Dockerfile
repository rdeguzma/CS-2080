FROM ubuntu:latest

RUN apt update
RUN apt install -y vim 
RUN apt install -y nginx

COPY app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh

CMD ["./app.sh"]

