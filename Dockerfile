FROM python:alpine

ENV PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=C.UTF-8
ENV PYTHONIOENCODING=UTF-8

RUN apk add --no-cache ca-certificates

CMD ["python3"]

EXPOSE 4025

WORKDIR /var/

RUN apk update && \
    apk upgrade && \
    apk add tzdata git bash sed

RUN git clone https://github.com/DeepPurple77/AlarmServer.git
COPY AlarmServer /var/AlarmServer
 
RUN pip install tornado

RUN pip uninstall -y wheel setuptools pip

COPY alarmserver.cfg /var/AlarmServer/

COPY run.sh /var/
RUN chmod +x /var/run.sh

COPY healthcheck.sh /var/
RUN chmod +x /var/healthcheck.sh

HEALTHCHECK --interval=5m CMD /var/healthcheck.sh

CMD /var/run.sh
