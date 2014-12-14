
require 'uri'
get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/new' do
	@url = ""
	entered_url = params[:url]
	if Url.create(original_url: entered_url, shortened_url: Url.random_string ).valid?
		@url = Url.create(original_url: entered_url, shortened_url: Url.random_string )
	end
	erb :new
end

get '/stats/:url' do
	entered_url = params[:url]
	@url = Url.where("shortened_url=?", entered_url).first
	@clicks = @url.clicks

	@times_array = []
	@clicks.each{|click| @times_array << click.created_at.to_s(:time)[0..1]}
	if @times_array.uniq.size > 5
		@times_array = Click.top_five_times(@times_array)
	else
		@times_array = @times_array.uniq
	end

	@referers_array = []
	@clicks.each do |click|
		if click.referer == "Typed in"
			@referers_array.push("Typed in")
		else
			@referers_array << URI(click.referer).host.capitalize
		end
	end
	@referers_array = @referers_array.uniq



	erb :stats
end

get '/:url' do
	@url = Url.where("shortened_url=?", params[:url]).first

	if request.referer == nil
		Click.create(referer: "Typed in" , url_id: @url.id)
	else
		Click.create(referer: request.referer , url_id: @url.id)
	end

	redirect @url.original_url
end
