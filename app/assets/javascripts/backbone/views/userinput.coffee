class Overflow.Views.UserInput extends Backbone.View
	initialize: (options) =>
		@model.bind("change", @render)

	loggedInTemplate: _.template('''<label for="newQuestion" id="questionPrompt"><%- author %> wants to know...</label>
		<textarea cols=20 rows=2 id="newQuestion" name="newQuestion"></textarea>
		<a id='addItem'>Ask now!</a>''')

	loggedOutTemplate: _.template('''<label id="logInPrompt">Your name:</label><input id="author" type=text/><a id="logIn">That's me!</a>''')

	events:
		"click #logIn" : "login"
		"click #addItem" : "newQuestion"

	newQuestion: =>
		textArea = $('#newQuestion')
		questionText = textArea.val()
		textArea.val("")

		question =
			content: questionText
			author: @model.get('author')
			votes: []

		Overflow.questions.create(question)

	login: =>
		author = $('#author').val()
		@model.set({author: author})

	render: =>
		if @model.isLoggedIn()
			activeTemplate = @loggedInTemplate
		else
			activeTemplate = @loggedOutTemplate
		@el.html( activeTemplate( @model.toJSON() ) )
		this
