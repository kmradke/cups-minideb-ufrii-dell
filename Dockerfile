FROM bitnami/minideb:buster

# Dell drivers are 32-bit only
RUN dpkg --add-architecture i386

# Install cups, python3, inotify-tools, dependent libs
RUN install_packages curl diffutils patch unzip vim cups printer-driver-all python3 python3-cups inotify-tools libxml2 libc6-i386 libxml2:i386 lib32z1 libjpeg62:i386 libstdc++6:i386

# Get custom drivers
WORKDIR /tmp/deb
RUN curl -sSkLo canon.tar.gz https://gdlp01.c-wss.com/gds/8/0100007658/18/linux-UFRII-drv-v520-uken-05.tar.gz \
  && tar xzvf canon.tar.gz --strip-components 3 --wildcards '*amd64.deb' '*all.deb' \
  && rm canon.tar.gz
RUN curl -sSkLo dell.zip https://dl.dell.com/FOLDER03004762M/1/Printer_E310dw_Driver_Dell_A00_LINUX.zip \
  && unzip -j dell.zip '*.deb' \
  && rm dell.zip

# Install custom drivers
RUN install_packages /tmp/deb/*.deb

# Scripts
ADD root /root
RUN chmod +x /root/*
CMD ["/root/run_cups.sh"]

# Patch files
ADD cupsd.conf.patch /etc/cups
RUN patch -b -i /etc/cups/cupsd.conf.patch /etc/cups/cupsd.conf

# CUPS uses port 631
EXPOSE 631

# Volume mounts
VOLUME /config
VOLUME /services
