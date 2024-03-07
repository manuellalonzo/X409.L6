FROM ubuntu:22.04
RUN apt-get -y update && apt-get install -y software-properties-common
RUN apt-get -y upgrade
RUN apt-get -y install gcc
RUN apt-get -y install git
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get -y update && apt-get install -y software-properties-common
RUN apt-get -y install python3.7
RUN apt-get -y install bash

ADD dummy_serv.c /

RUN gcc -o dummyserv dummy_serv.c

EXPOSE 12344 



#CMD ["/bin/bash", "-c" ,"git --version && python3.7 --version && ./dummyserv"]
CMD ["./dummyserv"] 



