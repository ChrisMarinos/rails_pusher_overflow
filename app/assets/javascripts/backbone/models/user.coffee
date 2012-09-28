class Overflow.Models.User extends Backbone.Model
	isLoggedIn: =>
		return true if @get('author')
		false
