# sank

A function for syncing with a timeserver using a Bacon property.

Only tested in the browser so far. Requires `$` to be bound to jquery.

### sank (timeServerURL, updateTimeInterval)
Returns a Bacon property representing the time diff (in ms) between client time and the timeserver. the property requests sends a request to timeServerURL every updateTimeInterval

`timeServerURL` must return an ISO-formatted date on a GET request.
