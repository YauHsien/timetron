# timetron in Erlang

## Usage

```
$ cd src && erl
1> {c(timetron), c(ntp)}.
{ok,timetron}
2> timetron:utc_time().
{{2024,5,15},{8,3,47}}
3> timetron:net().
{"pool.ntp.org",
 [{114,35,131,27},
  {125,229,162,223},
  {17,253,116,253},
  {103,147,22,149}]}
4> net:get_time().
{{li,0},
 {vn,4},
 {mode,4},
 {stratum,2},
 {poll,3},
 {precision,-23},
 {rootDelay,844},
 {rootDispersion,1590},
 {referenceId,216,239,35,8},
 {referenceTimestamp,1715768468.0777907},
 {originateTimestamp,-2208988800},
 {receiveTimestamp,1715768827.1037784},
 {transmitTimestamp,1715768827.3995132},
 {clientReceiveTimestamp,1715768976.38},
 {offset,-148.980486869812}}
5> halt().
$
```
