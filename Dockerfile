FROM python:2.7-alpine

EXPOSE 4025

WORKDIR /var/

VOLUME /var/AlarmServer/alarmserver.cfg

RUN apk update && \
    apk upgrade && \
    apk add git bash sed
RUN git clone https://github.com/DeepPurple77/AlarmServer.git

RUN pip install tornado

COPY alarmserver.cfg /var/AlarmServer/
COPY run.sh /var/

RUN chmod +x /var/run.sh

CMD /var/run.sh
