This script implements example notify script in Perl which implements JSON interface for FastNetMon Advanced.

NB! JSON based script uses different arguments from text based notify script. Please keep it in mind!

You may check thios guide on our [site](https://fastnetmon.com/docs-fnm-advanced/fastnetmon-advanced-notify-script-in-perl/).

Please install JSON processing library for Perl:
```
sudo apt-get install -y libjson-perl
```

It prints all information received from FastNetMon to log file /tmp/fastnetmon_notify_script.log. You need to download it from GitHub:
```
wget https://raw.githubusercontent.com/FastNetMon/fastnetmon_notify_perl/main/notify_json.pl
chmod +x notify_json.pl
sudo cp notify_json.pl /usr/local/bin/notify_json.pl
```

You need to use following mode from FastNetMon to use this script properly:
```
sudo fcli set main notify_script_enabled enable
sudo fcli set main notify_script_format json
sudo fcli set main notify_script_path /usr/local/bin/notify_json.pl
sudo fcli commit
```

More documentation about [JSON](https://fastnetmon.com/fastnetmon-json-formats/) formats you could find here.
