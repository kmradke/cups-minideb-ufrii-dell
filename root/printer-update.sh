#!/bin/bash
inotifywait -m -e close_write,moved_to,create /etc/cups | 
while read -r directory events filename; do
	if [ "$filename" = "printers.conf" ]; then
	        echo "+++ Removing old Airprint service files..."
		rm -rf /services/AirPrint-*.service
		echo "+++ Generating airprint service files..."
		/root/airprint-generate.py -d /services
		echo "+++ Persisting printer configuration..."
		cp /etc/cups/printers.conf /config/printers.conf
	fi
done
