vote_time = {}
function vote_time.start_vote(name, param, time, description, sd)
	if not(type(time) == "number") then
		error("Vote Time Function: Time not number")
	end
	vote.new_vote(name, {
		description = description,
		help = "/yes,  /no  or  /abstain",
		name = param,
		duration = 60,

		on_result = function(self, result, results)
			if result == "yes" then
				minetest.chat_send_all("Vote passed, " ..
                        #results.yes .. " to " .. #results.no .. ", Time will be set to "..sd)
                        minetest.set_timeofday(time)
				
			else
				minetest.chat_send_all("Vote failed, " ..
						#results.yes .. " to " .. #results.no .. ", "
						)
			end
		end,
    

		on_vote = function(self, name, value)
			minetest.chat_send_all(name .. " voted " .. value .. " to '" ..
					self.description .. "'")
		end
	})
end

minetest.register_chatcommand("vote_day", {
	privs = {
		interact = true
	},
	func = function(name, param)
		vote_time.start_vote(name, param, 0.5, "Make day "..param, "day ")
	end
})

minetest.register_chatcommand("vote_night", {
	privs = {
		interact = true
	},
	func = function(name, param)
		vote_time.start_vote(name, param, 0, "Make night "..param, "night ")
	end
})
