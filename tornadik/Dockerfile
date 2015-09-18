FROM python:latest

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/GageGaskins/tornadik.git

WORKDIR /tornadik

RUN pip install -U -r requirements.txt