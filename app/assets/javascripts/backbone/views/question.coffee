class Overflow.Views.QuestionView extends Backbone.View
  initialize: (options) =>
    @model.bind("change", @render)
    @model.get('votes').bind("change", @render)
    @model.get('votes').bind("add", @render)
    @model.get('votes').bind("remove", @render)

  tagName: "li"
 
  className: "question"

  template: _.template('''
    <div class=questionStatus>
      <div class="voteup <%=voteUpClass%>">&nbsp;</div>
      <div class=votecount><%= tally %></div>
      <div class="votedown <%=voteDownClass%>">&nbsp;</div>
    </div>
    <div class=questionText>
      <p><%- content %></p>
      <div class="questionAuthor">From: <%- author %></div>
    </div>
    ''')
  
  events:
    "click .voteup" : 'upVote'
    "click .votedown" : 'downVote'

  render: =>
    author = Overflow.currentUser.author
    voteInfo = {}
    voteInfo.voteUpClass = if @model.didUserVoteUp author then "votedup" else ""
    voteInfo.voteDownClass = if @model.didUserVoteDown author then "voteddown" else ""
    voteInfo.tally = @model.voteTally()
    voteInfo.content = @model.get('content')
    voteInfo.author = @model.get('author')
    newContent = @template(voteInfo)
    $(@el).html(newContent)
    return this

  upVote: =>
    @setVote('up')

  downVote: =>
    @setVote('down')

  setVote: (voterType) =>
    author = Overflow.currentUser.get('author')
    questionId = @model.id

    vote = @model.getExistingVote author

    if vote
        unless vote.get('voter_type') == voterType
            vote.set(voter_type: voterType)
            vote.save()
    else
        @model.get('votes').create
            voter_type: voterType,
            question_id: questionId,
            voter: author
