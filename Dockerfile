FROM natechoe/ncdg AS ncdg

FROM natechoe/swebs
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y make gcc
RUN [ "rm", "-rf", "/site" ]
COPY --from=ncdg /usr/bin/ncdg /usr/bin/ncdg
COPY ./site /site
WORKDIR /site
RUN [ "make" ]
RUN [ "mkdir", "/secrets" ]

ENTRYPOINT [ "swebs", "-s", "/site/sitefile", "-o", "/dev/stdout" ]
