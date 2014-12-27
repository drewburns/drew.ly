get '/user/:id' do
	@user = User.find_by_id(params[:id])
	erb :user
end