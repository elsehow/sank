$ = require 'jquery'
Bacon = require 'baconjs'
Bacon$ = require 'bacon.jquery.ajax'
moment = require 'moment'

timediff = (one, the_other) -> moment(the_other).diff(one)
getServerTime = (timeDiff) -> moment().utc().add(timeDiff)
isTruthy = (item) -> if item then item

# returns a Bacon property representing the 
# the property requests sends a request to timeServerURL every updateTimeInterval
getTimeDiffProp = (timeServerURL, updateTimeInterval) ->

        # ask for the time on an interval
        timeRequests = Bacon.interval(updateTimeInterval)
                .map(() -> return {url:timeServerURL})

        serverTimeResults = timeRequests
        	.ajax()
        	.map((t) -> timediff(moment(t), moment()))
        	.filter(isTruthy)

        return serverTimeResults.toProperty(null)

module.exports = getTimeDiffProp