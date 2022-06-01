FROM natechoe/swebs
RUN [ "rm", "-rf", "/site" ]
COPY ./site /site
# Copy over the site and the swebs binary
RUN [ "mkdir", "/secrets" ]

ENTRYPOINT [ "swebs", "-s", "/site/sitefile", "-o", "/dev/stdout" ]
