class Overflow.Models.Question extends Backbone.Model
    paramRoot: 'question'

    initialize: (attributes) =>
        @set votes: new Overflow.Collections.Votes(attributes.votes, {id: attributes.id})

    getExistingVote: (author) =>
        @get('votes').find (vote) => vote.get('voter') == author

    didUserVoteUp: (currentUser) =>
        vote = @getExistingVote(currentUser)
        vote.voterType == 'up' if vote

    didUserVoteDown: (currentUser) =>
        vote = @getExistingVote(currentUser)
        vote.voterType == 'down' if vote

    voteTally: =>
        voteBreakdown = @get('votes').reduce( @voteIncrement, {up:0, down:0} )
        return voteBreakdown.up - voteBreakdown.down

    voteIncrement: (tally,vote) ->
        upIncrement = if vote.get('voter_type') == 'up' then 1 else 0
        downIncrement = if vote.get('voter_type') == 'down' then 1 else 0
        {up: tally.up + upIncrement, down: tally.down + downIncrement}
