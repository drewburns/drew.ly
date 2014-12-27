get '/login' do
	erb :login
end

post '/login' do
	user = User.where("username = ?", (params[:username_input]).downcase ).first
	if user == nil 
		@login_error = "This account doesn't exist"
		erb :login
	else

		user = User.where("username = ?", (params[:username_input]).downcase ).first
		session[:user_id] = user.id

		@current_user = current_user
		@stuff = logged_in?

		erb :index
	end
end

get '/logout' do
	session[:user_id] = nil

	redirect "/"
end

post '/newaccount' do
	user = User.new(username: params[:username_input].downcase)
	if user.valid?
		new_user = User.create(username: params[:username_input].downcase)
		session[:user_id] = new_user.id

		@current_user = current_user
		@stuff = logged_in?

		erb :index
	else
		@error = "Username already being used!"
		erb :login

	end
end
