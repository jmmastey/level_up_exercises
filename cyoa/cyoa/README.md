## Front-end Resources
[Haml](http://haml.info/)


## Heroku
mysterious-plateau-4257
http://mysterious-plateau-4257.herokuapp.com/ | git@heroku.com:mysterious-plateau-4257.git

http://intense-beyond-8711.herokuapp.com/ | git@heroku.com:intense-beyond-8711.git

## Data Visualization
[High Charts](http://www.highcharts.com/products/highmaps)


[]()
https://github.com/pilu/active_musicbrainz


```
$ sudo su
$ ARCHFLAGS="-arch x86_64" gem install pg
```


"Whenever"" gem

Devise gem



## Insertion Benchmarking Results


Original
 
```
T1=> #<Benchmark::Tms:0x007fdafd4797a0 @label="", @real=9.34182, @cstime=0.0, @cutime=0.0, @stime=0.36, @utime=5.83, @total=6.19>
T2=> #<Benchmark::Tms:0x007fdafc669070 @label="", @real=10.27735, @cstime=0.0, @cutime=0.0, @stime=0.3600000000000001, @utime=5.690000000000001, @total=6.050000000000002>
```

With ActiveRecord::Base.transactions

```
T1=> #<Benchmark::Tms:0x007fdaff1c1128 @label="", @real=9.152074, @cstime=0.0, @cutime=0.0, @stime=0.3800000000000001, @utime=5.68, @total=6.06>
T2=> #<Benchmark::Tms:0x007fdafd3c9fa8 @label="", @real=9.017712, @cstime=0.0, @cutime=0.0, @stime=0.3600000000000003, @utime=5.199999999999999, @total=5.56>
```

Mass Insert with Active Record

```
T1=> #<Benchmark::Tms:0x007fdb03011bd0 @label="", @real=9.364155, @cstime=0.0, @cutime=0.0, @stime=0.4299999999999997, @utime=5.590000000000003, @total=6.020000000000003>
T2=> #<Benchmark::Tms:0x007fdafc6c28f0 @label="", @real=10.260914, @cstime=0.0, @cutime=0.0, @stime=0.4500000000000002, @utime=5.329999999999998, @total=5.7799999999999985>
T3=> #<Benchmark::Tms:0x007fdb030b28c8 @label="", @real=16.910623, @cstime=0.0, @cutime=0.0, @stime=0.4299999999999997, @utime=5.339999999999996, @total=5.769999999999996>
```

Mass Insert with SQL

```
T1=> #<Benchmark::Tms:0x007fdafde53118 @label="", @real=1.957452, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.15000000000000568, @total=0.15000000000000568>
T2=> #<Benchmark::Tms:0x007fdaff222310 @label="", @real=2.222488, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.05000000000001137, @total=0.05000000000001137>
T3=> #<Benchmark::Tms:0x007fdafc757e78 @label="", @real=2.471284, @cstime=0.0, @cutime=0.0, @stime=0.009999999999999787, @utime=0.05000000000001137, @total=0.060000000000011156>
```



