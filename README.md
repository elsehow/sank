# sank

two Bacon.js helper functions for syncing a browser's local time with a timeserver

## API

### sank.getTimeDiffStream (timeServerURL, updateTimeInterval)

this function requests the time from timeServerURL on the specified interval. 

and returns a Bacon stream of time differences

(NB. it expects the timeServerURL to return nothing but a date on GET request)

### sank.getSynchronisedTimeProperty (timeDiffStream, pollLocalClockInterval)

this function returns a Bacon property representing the user's local time, synchronised to the timeserver's time

it takes a timeDiffStream (which can be produced using the other function in this package), and an interval at which it should poll the user's internal clock.

returns the synchronised time property that updates on pollLocalClockInterval.


