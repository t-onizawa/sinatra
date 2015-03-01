require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

ActiveRecord::Base.establish_connection(
	"adapter" => "sqlite3",
	"database" => "./bbs.db"
)

before do
	@jquery = "https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"
	@destroy = "/js/destroy.js"
end

helpers do
	include Rack::Utils
	alias_method :h, :escape_html
end

class Comment < ActiveRecord::Base
end

get '/' do
	@comment = Comment.order("id desc").all
	@js = [
		@jquery,
		@destroy
	]
	erb :index
end

post '/new' do
	Comment.create({:body => params[:body]})
	redirect '/'
end

post '/delete' do
	Comment.find(params[:id]).destroy
end


=begin

before '/admin/*' do
	@msg = "Hello, User!"
end

before do
	@author = "Onizawa"
end

after do
	logger.info "page displayed successfully"
end

helpers do

	def strong(s)
		"<strong>#{s}</storong>"
	end

end



get '/hello/:name' do
	"Hello #{params[:name]}"
end

get '/hello/:name' do |n|
	"Hello #{n}"
end

get '/hello/:fname/?:lname?' do |f, l|
	"Hello #{f} #{l}"
end

get '/form/*/to/*' do |f, t|
	"from #{f} to #{t}"
end

get %r{/users/([0_9]*)} do |i|
	"user id = #{i}"
end

get '/' do |n|
	@title = "Main Index"
	@content = "Main Content by" + strong(@author)
	erb :index
end

get '/about' do |n|
	@title = "About Index"
	@content = "About Content by" + strong(@author)
	@email = "tetsuya.onizawa@gmail.com"
	erb :index
end

=end
