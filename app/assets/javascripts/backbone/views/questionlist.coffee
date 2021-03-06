class Overflow.Views.QuestionListView extends Backbone.View
  initialize: ->
    Overflow.questions.bind 'reset', @render
    Overflow.questions.bind 'add', @renderItem
    Overflow.questions.fetch()
  
  render: =>
    $(@el).html("")
    Overflow.questions.each(@renderItem)
    this
  
  renderItem: (question) =>
    view = new Overflow.Views.QuestionView(model: question)
    $(@el).append(view.render().el)
