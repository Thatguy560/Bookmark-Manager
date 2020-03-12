require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base 
  enable :sessions

  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    # session[:bookmarks] = BookmarkManager.new.show_bookmarks
    # erb :bookmarks
    p ENV
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do 
    @bookmarks = Bookmark.all
    erb :'bookmarks/new'
  end
  
  post '/bookmarks' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks' # Once we've submitted our date this will link us back to the bookmarks page where it's saved.
  end

  # post '/bookmarks/new' do
  #   Bookmark.create(url: params[:url], title: params[:title])
  #   redirect '/bookmarks'
  # end
  
  run! if app_file == $0
end 