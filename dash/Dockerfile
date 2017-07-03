FROM hypriot/rpi-python:latest
MAINTAINER Max Nowack <max@unsou.de>

RUN apt-get update && apt-get -y install scapy tcpdump

ADD main.py main.py
CMD ["python", "main.py"]
