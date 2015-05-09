require "sinatra"
require "shotgun"
require "sinatra/activerecord"
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

enable :sessions

class Dota < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
  	validates :tuto, presence: true
end

get '/' do
	$title = "CloseClassroom"
	erb :index
end

helpers do
  def title
    if @title
      "#{@title}"
    else
      "CloseClassroom | Créez votre tutoriel"
    end
  end
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

# create new post
get "/creer_tutoriel" do
  $title = "CloseClassroom | Créez votre tutoriel"
  @dota = Dota.new
  erb :form
end

get '/cours' do
  @dota = Dota.order("created_ DESC")
  @dota = Dota.all
  $title = "CloseClassroom | Nos Cours"
  erb :cours #A ecrire en premier
end

post "/validation" do
  @dota = Dota.new(params[:dota])
  if @dota.save
    redirect "/cours", :notice => 'Congrats! Love the new post. (This message will disapear in 4 seconds.)'
  else
    redirect "/cours/creer_tutoriel", :error => 'Something went wrong. Try again. (This message will disapear in 4 seconds.)'
  end
end

# view post
get "/cours/:id" do
  @dota = Dota.find(params[:id])
  $title = "CloseClassroom | Nos Cours | " + @dota.title
  erb :view
end

# edit post
get "/cours/:id/edit" do
  @dota = Dota.find(params[:id])
  $title = "CloseClassroom | Edit Cours"
  erb :edit
end
put "/cours/:id" do
  @dota = Dota.find(params[:id])
  @dota.update(params[:dota])
  redirect "/cours/#{@dota.id}"
end
