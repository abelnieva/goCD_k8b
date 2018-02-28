FROM gocd/gocd-server:v17.6.0

RUN apk update
RUN apk add apache2-utils

ENV TINI_SUBREAPER=true
ADD custom-boot.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/custom-boot.sh
CMD ["custom-boot.sh"]
