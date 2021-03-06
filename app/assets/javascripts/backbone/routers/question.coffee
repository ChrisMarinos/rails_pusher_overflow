class Overflow.Routers.QuestionRouter extends Backbone.Router
	initialize: (options) =>
		Overflow.pusher = new Pusher(Overflow.pusherKey)
		Overflow.currentUser = new Overflow.Models.User
		@userInputView = new Overflow.Views.UserInput({model: Overflow.currentUser, el: $('#newQuestions')})
		@userInputView.render()
		Overflow.questions = new Overflow.Collections.QuestionList()
		@questionListView = new Overflow.Views.QuestionListView(el: $('#questions'))
		channel = Overflow.pusher.subscribe(Overflow.channel)
		new Backpusher(channel, Overflow.questions)


#Backbone.socket.on "questions:updated", (data) ->
    #question = Overflow.Questions.get(data.id)
    #if(question)
        #question.set({'votes':data.votes})
    #else
        #Overflow.Questions.add(data)
