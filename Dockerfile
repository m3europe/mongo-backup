FROM mongo:latest
RUN mkdir /data/mongodb_bkp
RUN mkdir /data/mongodb_bkp/dump
RUN mkdir /data/mongodb_bkp_script
ADD mongodb_bkp.sh /data/mongodb_bkp_script/mongo_bkp.sh
WORKDIR /data/mongodb_bkp_script
CMD ["./mongodb_bkp.sh" ]
