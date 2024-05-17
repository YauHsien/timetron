-module(courier).
-behavior(gen_server).
-export([get_courier/1]).
-export([init/1, handle_call/3, handle_cast/2]).

-record(timetron_config, {interval}).

-define(SEC_THRESHOLD, 1001).
-define(COURIER, self()).



get_courier(Interval) ->
    gen_server:start_link(?MODULE, [#timetron_config{interval=Interval}], []).


init([TimetronConfig= #timetron_config{}]) ->
    timer:apply_interval(TimetronConfig#timetron_config.interval, gen_server, cast, [self(), timing]),
    {ok, {}}.

handle_call(stop, _From, State) ->
    {stop, normal, ok, State};
handle_call(_Request, _From, State) ->
    {reply, State}.

handle_cast(timing, State) ->
    timing(),
    {noreply, State};
handle_cast({local,T,N}, State) ->
    io:fwrite("~p received~n", [{local,T,N}]),
    {noreply, State};
handle_cast({universal,T}, State) ->
    io:fwrite("~p received~n", [{universal,T}]),
    {noreply, State};
handle_cast(_Request, State) ->
    {noreply, State}.




timing() ->
    case ntp:get_time() of
        {error,_} ->
            gen_server:cast(?COURIER, {local, ntp:get_local_time(), self()});
        Term ->
            case { lists:keyfind(offset, 1, Term)
                 , lists:keyfind(clientReceiveTimestamp, 1, Term) } of
                {{offset,Offset}, _} when abs(Offset) > ?SEC_THRESHOLD ->
                    gen_server:cast(?COURIER, {local, ntp:get_local_time(), self()});
                {_, {clientReceiveTimestamp,Timestamp}} ->
                    gen_server:cast(?COURIER, {universal, Timestamp})
            end
    end.
