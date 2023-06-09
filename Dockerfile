FROM python:alpine

EXPOSE 4025

WORKDIR /var/

RUN apk update && \
    apk upgrade && \
    apk add git bash sed
RUN git clone -b feature/python3 https://github.com/DeepPurple77/AlarmServer.git

RUN pip install tornado

COPY alarmserver.cfg /var/AlarmServer/
COPY run.sh /var/

RUN chmod +x /var/run.sh

CMD /var/run.sh
