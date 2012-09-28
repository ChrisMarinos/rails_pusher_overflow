class Overflow.Models.Question extends Backbone.Model
	didUserVote: (currentUser,voterType) =>
		author = currentUser.get('author')
		votes = @get('votes')
		_(votes).any (vote)=>
			vote.author == author and vote.voterType == voterType

	didUserVoteUp: (currentUser) =>
		@didUserVote currentUser, 'up'

	didUserVoteDown: (currentUser) =>
		@didUserVote currentUser,'down'

	voteTally: =>
		votes = @get('votes')
		voteBreakdown = _(votes).reduce( @voteIncrement, {up:0, down:0} )
		return voteBreakdown.up - voteBreakdown.down

	voteIncrement: (tally,vote) ->
		upIncrement = if vote.voterType == 'up' then 1 else 0
		downIncrement = if vote.voterType == 'down' then 1 else 0
		{up: tally.up + upIncrement, down: tally.down + downIncrement}
