#!/usr/bin/env /home/HSCNET/yli/RITA/p27/bin/python

import sys
from influxdb import InfluxDBClient

client = InfluxDBClient('localhost', 8086, 'paul', 'timeseries', 'mydb')

with open(sys.argv[1]) as f:
    for line in f:
        ts, records, bytes, packets = line.strip().split("|")[:4]
        json_body = [{"measurement": sys.argv[1].split(".")[0], 
                    "time": ts.replace("/", "-").strip()+"Z", 
                    "fields": {
                        "records": float(records.strip()),
                        "bytes": float(bytes.strip()),
                        "packets": float(packets.strip()) 
                    }}]
        client.write_points(json_body)
