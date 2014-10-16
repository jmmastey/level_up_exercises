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
T1=> #<Benchmark::Tms:0x007f96b0523728 @label="", @real=2.983779, @cstime=0.0, @cutime=0.0, @stime=0.07999999999999996, @utime=0.16000000000000014, @total=0.2400000000000001>
T2=> #<Benchmark::Tms:0x007f96ac013c78 @label="", @real=3.12616, @cstime=0.0, @cutime=0.0, @stime=0.08999999999999986, @utime=0.16999999999999993, @total=0.2599999999999998>
```


LiveController
ActiveRecord Import



