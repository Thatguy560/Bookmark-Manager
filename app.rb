require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base 
  enable :sessions

  # get '/' do
  #   "Bookmark Manager"
  # end

  get '/bookmarks' do
    # session[:bookmarks] = BookmarkManager.new.show_bookmarks
    # erb :bookmarks
    p ENV
    @bookmarks = Bookmark.all
    # @bookmarks = ["http://www.makersacademy.com",
    # "http://www.destroyallsoftware.com",
    # "http://www.google.com"]
    # # bookmarks.join
    erb :'bookmarks/index'
  end
  
  run! if app_file == $0
end 