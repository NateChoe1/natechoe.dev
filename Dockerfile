FROM natechoe/ncdg AS build
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y make
COPY ./site /site
WORKDIR /site
RUN [ "make" ]

FROM natechoe/swebs
RUN [ "rm", "-rf", "/site" ]
COPY --from=build /site /site
RUN [ "mkdir", "/secrets" ]

ENTRYPOINT [ "swebs", "-s", "/site/sitefile", "-o", "/dev/stdout" ]
