-module(timetron).
-export([utc_time/0, net/0]).
-include_lib("kernel/include/inet.hrl").

-define(NTP_SERVER, "pool.ntp.org").


utc_time() ->
    calendar:universal_time().


net() ->
    case inet:gethostbyname(?NTP_SERVER) of
        {ok, Rec} -> {Rec#hostent.h_name, Rec#hostent.h_addr_list};
        {error, Reason} -> {error, Reason}
    end.

