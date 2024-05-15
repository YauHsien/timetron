
-module(timetron).
-export([utc_time/0, net/0]).
-include_lib("kernel/include/inet.hrl").

-behavior(gen_server).
-export([init/1, handle_call/3, handle_cast/2]).

-define(NTP_SERVER, "pool.ntp.org").


utc_time() ->
    calendar:universal_time().


net() ->
    case inet:gethostbyname(?NTP_SERVER) of
        {ok, Rec} -> {Rec#hostent.h_name, Rec#hostent.h_addr_list};
        {error, Reason} -> {error, Reason}
    end.


init([]) ->
    {ok, {}}.

handle_call(stop, _From, State) ->
    {stop, normal, ok, State};
handle_call(_Request, _From, State) ->
    {reply, State}.

handle_cast({local,T,N}, State) ->
    io:fwrite("~p received~n", [{local,T,N}]),
    {noreply, State};
handle_cast({universal,T}, State) ->
    io:fwrite("~p received~n", [{universal,T}]),
    {noreply, State};
handle_cast(_Request, State) ->
    {noreply, State}.
