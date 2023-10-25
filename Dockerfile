FROM natechoe/ncdg AS ncdg

FROM natechoe/swebs
RUN apt-get update -y --allow-releaseinfo-change && apt-get upgrade -y && apt-get install -y make gcc
RUN [ "rm", "-rf", "/site" ]
COPY --from=ncdg /usr/bin/ncdg /usr/bin/ncdg
COPY ./site /site
RUN mkdir /secrets && mkdir /core && chmod 777 /core
# core is for core dumps

ENTRYPOINT /site/start.sh
