

// ===================================================
// ========================================CPU Metrics 

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["_field"] == "value")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "cpu")
  |> filter(fn: (r) => r["type_instance"] == "interrupt" 
                    or r["type_instance"] == "nice" 
                    or r["type_instance"] == "softirq" 
                    or r["type_instance"] == "steal" 
                    or r["type_instance"] == "system" 
                    or r["type_instance"] == "user" 
                    or r["type_instance"] == "wait")
  |> derivative(unit: v.windowPeriod, nonNegative: false)
  |> yield(name: "derivative")

// ===================================================
// ========================================LOAD METRICS

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "load")
  |> filter(fn: (r) => r["_field"] == "shortterm" 
                    or r["_field"] == "midterm" 
                    or r["_field"] == "longterm")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")

// ===================================================
// =====================================MEMORY METRICS

// AS PERCENT: 
from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "memory")
  |> filter(fn: (r) => r["type"] == "percent")
  |> filter(fn: (r) => r["_field"] == "value")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")

// AS BYTES
from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "memory")
  |> filter(fn: (r) => r["type"] == "memory")
  |> filter(fn: (r) => r["_field"] == "value")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")

// ===================================================
// =====================================NETWORK METRICS

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["_field"] == "tx" 
                    or r["_field"] == "rx")
  |> filter(fn: (r) => r["plugin"] == "interface")
  |> filter(fn: (r) => r["plugin_instance"] == "enp1s0")
  |> filter(fn: (r) => r["type"] == "if_octets")
  |> derivative(unit: v.windowPeriod, nonNegative: false)
  |> yield(name: "derivative")

// ===================================================
// ====================================STORAGE METRICS

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["_field"] == "value")
  |> filter(fn: (r) => r["plugin"] == "df")
  |> filter(fn: (r) => r["type"] == "df_inodes" 
                    or r["type"] == "df_complex")
  |> filter(fn: (r) => r["plugin_instance"] == "root")
  |> filter(fn: (r) => r["type_instance"] == "used" 
                    or r["type_instance"] == "reserved" 
                    or r["type_instance"] == "free")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")

// ===================================================
// ==============================DISK IOPS/THROUGHTPUT

// DISK THROUGHPUT
from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "disk")
  |> filter(fn: (r) => r["plugin_instance"] == "vda")
  |> filter(fn: (r) => r["type"] == "disk_octets")
  |> filter(fn: (r) => r["_field"] == "read" 
                    or r["_field"] == "write")
  |> derivative(unit: v.windowPeriod, nonNegative: false)
  |> yield(name: "derivative")

// DISK IOPS
from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "disk")
  |> filter(fn: (r) => r["plugin_instance"] == "vda")
  |> filter(fn: (r) => r["type"] == "disk_ops")
  |> filter(fn: (r) => r["_field"] == "read" 
                    or r["_field"] == "write")
  |> derivative(unit: v.windowPeriod, nonNegative: false)
  |> yield(name: "derivative")

// DISK IO TIME
from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "collectd")
  |> filter(fn: (r) => r["host"] == "agent")
  |> filter(fn: (r) => r["plugin"] == "disk")
  |> filter(fn: (r) => r["plugin_instance"] == "vda")
  |> filter(fn: (r) => r["type"] == "disk_io_time")
  |> filter(fn: (r) => r["_field"] == "weighted_io_time")
  |> derivative(unit: v.windowPeriod, nonNegative: false)
  |> yield(name: "derivative")
