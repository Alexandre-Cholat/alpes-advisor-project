% Default rule: a resort is snowy if a known altitude reaches the threshold,
% unless there is a known exception (exception/1). Unknown altitude: snow is possible, never certain.
#defined exception/1. % avoids a warning if no exception is given
