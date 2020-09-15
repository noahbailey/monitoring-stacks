

// ===================================================
// ========================================CPU Metrics 

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => 
        r._field == "value" or 
        r._field == "type" and r._value == "cpu" or 
        r._field == "type_instance" and r._value == "system" or
        r._field == "host" and r._value == "agent"
    )
  |> aggregateWindow(every: v.windowPeriod, fn: last, createEmpty: false)
  |> yield(name: "mean")

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => 
        r._field == "value" or 
        r._field == "type" and r._value == "cpu" or 
        r._field == "type_instance" and r._value == "user" or
        r._field == "host" and r._value == "agent"
    )
  |> aggregateWindow(every: v.windowPeriod, fn: last, createEmpty: false)
  |> yield(name: "last")



// ===================================================
// ========================================LOAD METRICS

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_field"] == "longterm" or r["_field"] == "midterm" or r["_field"] == "shortterm" or
        r._field == "type" and r._value == "load" or 
        r._field == "host" and r._value == "agent"
    )
  |> aggregateWindow(every: v.windowPeriod, fn: last, createEmpty: false)
  |> yield(name: "mean")


// ===================================================
// =====================================MEMORY METRICS

from(bucket: "metrics")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => 
        r._field == "value" or 
        r._field == "type" and r._value == "memory" or 
        r._field == "type_instance" and r._value == "used" or
        r._field == "host" and r._value == "agent"
    )
  |> aggregateWindow(every: v.windowPeriod, fn: last, createEmpty: false)
  |> yield(name: "last")
