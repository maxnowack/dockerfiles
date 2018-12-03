FROM vekerdyb/rpi-python3

RUN apk update && apk add unzip wget libffi-dev openssl-dev
WORKDIR /app
RUN wget --no-check-certificate https://github.com/stigger/trakt-for-appletv/archive/master.zip
RUN unzip master.zip
RUN mv trakt-for-appletv-master/* .
RUN pip3 install -r requirements.txt

CMD ["python3", "./tvscrobbler.py "]
