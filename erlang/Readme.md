# timetron in Erlang

## Usage

```
$ cd src && erl
1> c(timetron).
{ok,timetron}
2> timetron:utc_time().
{{2024,5,15},{8,3,47}}
3> timetron:net().
{"pool.ntp.org",
 [{114,35,131,27},
  {125,229,162,223},
  {17,253,116,253},
  {103,147,22,149}]}
4> halt().
$
```
