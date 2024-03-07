FROM ubuntu:22.04
RUN apt-get -y update 
RUN apt-get -y upgrade
RUN apt-get -y install gcc
RUN apt-get -y install git
RUN apt-get -y install bash

ADD dummy_serv.c /

RUN gcc -o dummyserv dummy_serv.c

EXPOSE 12344 



#CMD ["/bin/bash", "-c" ,"git --version && python3.7 --version && ./dummyserv"]
CMD ["./dummyserv"] 



