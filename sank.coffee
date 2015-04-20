Bacon = require 'baconjs'
moment = require 'moment'

timediff = (one, the_other) -> moment(the_other).diff(one)
getServerTime = (timeDiff) -> moment().utc().add(timeDiff)

getTimeDiffStream = (timeServerURL, updateTimeInterval) ->

	# ask for the time on an interval
	timeRequests = Bacon.interval(updateTimeInterval)
		.map(() -> return {url:timeServerURL})

	# make ajax requests to the server 
	serverTimeResults = timeRequests.ajax()

	# whenever a result comes in from the tiemserver
	timeDiffStream = serverTimeResults
		# get the difference between server's time and our time
		.map((t) -> timediff(moment(t), moment()))

	timeDiffStream

getSynchronisedTimeProperty = (timeDiffStream, pollLocalClockInterval) ->

	# mutable value we use to calculate time
	timeDiff = null
	# on each response from the timeserver.
	timeDiffStream.onValue((t)-> timeDiff = t)

 	# asnyc polling to get local time
	synchronisedTimeProperty = Bacon.fromPoll(
		pollLocalClockInterval, () -> 
		 	# we only get a timediff when we've heard from the server.
			if timeDiff
				return getServerTime(timeDiff)
			else 
				return null)
		.toProperty()

	synchronisedTimeProperty
		.filter((v) -> if v then v)

exports.getTimeDiffStream = getTimeDiffStream
exports.getSynchronisedTimeProperty = getSynchronisedTimeProperty 