FROM ubuntu:18.04 AS mod_tile

RUN apt-get update && \
    apt-get install -y git build-essential cmake autoconf libtool apache2-dev libmapnik-dev

RUN curl -L https://github.com/openstreetmap/mod_tile/archive/master.tar.gz | tar -zxf - && \
    cd mod_tile-master && \
    ./autogen.sh && \
    ./configure && \
    make -j $(nproc) && \
    make -j $(nproc) install-mod_tile && \
    ldconfig



FROM httpd:2.4

ENV RENDERD_PORT=7653

RUN apt-get update && apt-get install -y libcurl3-gnutls

COPY --from=mod_tile /usr/lib/apache2/modules/mod_tile.so /usr/local/apache2/modules/mod_tile.so

COPY /config/mod_tile.conf /usr/local/apache2/conf/extra/mod_tile.conf
COPY /config/renderd.ini /conf/renderd.ini
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule tile_module /usr/local/apache2/modules/mod_tile.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "Include /usr/local/apache2/conf/extra/mod_tile.conf" >> /usr/local/apache2/conf/httpd.conf
