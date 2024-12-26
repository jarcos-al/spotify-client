FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="arcos"

# title
ENV TITLE=Spotify

# Instalar Spotify y sus dependencias
RUN apt-get update && \
    apt-get install -y curl gnupg xvfb mesa-utils libgl1-mesa-dri libdbus-1-3 libayatana-appindicator3-1 libdbusmenu-glib4 && \
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg && \
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list && \
    apt-get update && \
    apt-get install -y spotify-client && \
    apt-get install -y dbus && \
    apt-get clean && rm -rf /var/lib/apt/lists/* \

# add local files
COPY /root /

# Exponer el puerto 3000 para KasmVNC
EXPOSE 3000

VOLUME /config
