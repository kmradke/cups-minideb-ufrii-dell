#!/bin/sh
set -e
set -x

if [ $(grep -ci $CUPSADMIN /etc/shadow) -eq 0 ]; then
    echo "+++ Adding lpadmin user..."
    useradd -r -G lpadmin -M $CUPSADMIN 
fi
echo $CUPSADMIN:$CUPSPASSWORD | chpasswd

mkdir -p /config/ppd
mkdir -p /services
rm -rf /etc/cups/ppd
ln -s /config/ppd /etc/cups
if [ ! -f /config/printers.conf ]; then
    echo "+++ Creating empty printer configuration..."
    touch /config/printers.conf
fi
echo "+++ Copying persisted printer configuration..."
cp /config/printers.conf /etc/cups/printers.conf

echo "+++ Launching printer updates in the background..."
/root/printer-update.sh &

echo "+++ Launching cupsd in the foreground..."
exec /usr/sbin/cupsd -f
