FROM mongo:latest
RUN mkdir -p /data/mongodb_bkp
RUN mkdir -p /data/mongodb_bkp/dump
RUN mkdir -p /data/mongodb_bkp_script
ADD mongodb_bkp.sh /data/mongodb_bkp_script
WORKDIR /data/mongodb_bkp_script
CMD ["./mongodb_bkp.sh" ]
