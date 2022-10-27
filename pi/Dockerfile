FROM telegraf:latest
# updated
RUN mkdir demo
WORKDIR /demo
COPY pi/requirements.txt .

RUN apt-get update
RUN apt-get install -y python3 python3-pip python3-dev python3-smbus i2c-tools

RUN usermod -aG i2c telegraf 


RUN pip3 install --no-cache-dir -r requirements.txt


