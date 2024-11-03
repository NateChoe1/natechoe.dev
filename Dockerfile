FROM natechoe/ncdg AS ncdg
FROM natechoe/nmark AS nmark

FROM natechoe/swebs
RUN apt-get update --allow-releaseinfo-change && apt-get upgrade -y && apt-get install -y make gcc nasm imagemagick source-highlight
RUN [ "rm", "-rf", "/site" ]
COPY --from=ncdg /usr/bin/ncdg /usr/bin/ncdg
COPY --from=nmark /usr/bin/nmark /usr/bin/nmark
RUN mkdir /secrets && mkdir /core && chmod 777 /core
# core is for core dumps

ENTRYPOINT /site/start.sh
