FROM natechoe/swebs
RUN [ "rm", "-rf", "/site" ]
COPY ./site /site
# Copy over the site and the swebs binary

ENTRYPOINT [ "swebs", "-s", "/site/sitefile" ]
