import datetime
import logging
import urllib2
import os

# Constants
timespan_threshhold = 3
url = os.environ.get('DASH_URL')

# Globals
lastpress = datetime.datetime(1970,1,1)

logging.getLogger("scapy.runtime").setLevel(logging.ERROR)
from scapy.all import *


def button_pressed_dash1():
  global lastpress
  thistime = datetime.datetime.now()
  timespan = thistime - lastpress
  if timespan.total_seconds() > timespan_threshhold:
    current_time = datetime.datetime.strftime(thistime, '%Y-%m-%d %H:%M:%S')
    print 'Dash button pressed at ' + current_time
    urllib2.urlopen(url)

  lastpress = thistime


def udp_filter(pkt):
  options = pkt[DHCP].options
  for option in options:
    if isinstance(option, tuple):
      if 'requested_addr' in option:
        # we've found the IP address, which means its the second and final UDP request, so we can trigger our action
        mac_to_action[pkt.src]()
        break

mac_to_action = {'ac:63:be:e9:0f:4f' : button_pressed_dash1, 'b4:7c:9c:01:60:f3': button_pressed_dash1}
mac_id_list = list(mac_to_action.keys())

print "Waiting for a button press..."
sniff(prn=udp_filter, store=0, filter="udp", lfilter=lambda d: d.src in mac_id_list)
