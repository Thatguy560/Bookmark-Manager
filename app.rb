require 'sinatra/base'
require_relative './lib/bookmark'
require_relative './lib/database_connection_setup.rb'

class BookmarkManager < Sinatra::Base 
  enable :sessions, :method_override

  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    # session[:bookmarks] = BookmarkManager.new.show_bookmarks
    # erb :bookmarks
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

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end
  # Adding and defining a route for this url.
  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :"bookmarks/edit"
  end
    # Patch allows full or partial updates to a file
    patch '/bookmarks/:id' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("UPDATE bookmarks SET url = '#{params[:url]}', title = '#{params[:title]}' WHERE id = '#{params[:id]}'")
    
      redirect('/bookmarks')
    end
    
  run! if app_file == $0
end 

# adding bookmark class to the html item list.
# We're also adding the delete button to index.erb