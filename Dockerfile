FROM debian:stable-slim AS build
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y libgnutls28-dev libgnutls30 gcc make pkg-config
COPY ./swebs /swebs
WORKDIR /swebs
RUN [ "./build.sh" ]
# Build swebs

FROM debian:stable-slim AS run
COPY ./site /site
COPY --from=build /swebs/build/swebs /usr/sbin/swebs
RUN useradd swebs
# Copy over the site and the swebs binary

ENTRYPOINT [ "swebs", "-s", "/site/sitefile" ]
# Run swebs
