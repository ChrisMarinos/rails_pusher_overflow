class Overflow.Collections.Votes extends Backbone.Collection
    model: Overflow.Models.Vote
    url: "votes"

    initialize: (models, options) =>
        @questionId = options.id
        channel = Overflow.pusher.subscribe('VOTES_CHANNEL_' + @questionId)
        new Backpusher(channel, this)

    parse: (response) =>
        _(response).filter (v) => v.question_id == @questionId
