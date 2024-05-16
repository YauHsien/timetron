-module(courier).
-behavior(gen_server).
-export([init/1, handle_call/3, handle_cast/2]).

-record(timetron_config, {interval}).




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
    UTCTime = calendar:universal_time(),
    gen_server:cast(self(), {universal, UTCTime}).
