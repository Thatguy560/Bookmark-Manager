# in lib/bookmark.rb
require 'pg'

class Bookmark
  def self.all
    connection = PG.connect(dbname: 'bookmark_manager') # we have created a pg object by installing PG gem. We can call connect on the PG object, passing in the database name.
    # This will return an object that we can send a query to, let's call that object connection.
    result = connection.exec("SELECT * FROM bookmarks;") # 
    # To retrieve bookmarks from the database, we'll call exec on the connection object, passing in a query string
    result.map { |bookmark| bookmark['url'] }
    # [
    #   "http://www.makersacademy.com",
    #   "http://www.destroyallsoftware.com",
    #   "http://www.google.com"
    #  ]
  end
end