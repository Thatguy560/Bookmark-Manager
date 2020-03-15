# in lib/bookmark.rb
# require 'pg'
require_relative 'database_connection'
# require_relative 'database_connection'
class Bookmark
  attr_reader :id, :title, :url 

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end
  # Self referring to the class it's in with .all being a method that calls all of the bookmarks in the database?
  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks")
    result.map do |bookmark|
      Bookmark.new(
        url: bookmark['url'],
        title: bookmark['title'],
        id: bookmark['id']
      )
  end
end
  # we are calling Bookmark.new with the ID, TITLE and URL from the bookmark we just retrieved from the database.

  def self.create(url:, title:)
    # if ENV['ENVIRONMENT'] == 'test'
    #   connection = PG.connect(dbname: 'bookmark_manager_test')
    # else
    #   connection = PG.connect(dbname: 'bookmark_manager')
    # end
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
     Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
   end

    def self.delete(id:)
      # if ENV['ENVIRONMENT'] == 'test'
      #   connection = PG.connect(dbname: 'bookmark_manager_test')
      # else
      #   connection = PG.connect(dbname: 'bookmark_manager')
      # end
      # connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
      DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
    end

    def self.update(id:, url:, title:)
      # if ENV['ENVIRONMENT'] == 'test'
      #   connection = PG.connect(dbname: 'bookmark_manager_test')
      # else
      #   connection = PG.connect(dbname: 'bookmark_manager')
      # end
      result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id} RETURNING id, url, title;")
      Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
    end

    def self.find(id:)
      # if ENV['ENVIRONMENT'] == 'test'
      #   connection = PG.connect(dbname: 'bookmark_manager_test')
      # else
      #   connection = PG.connect(dbname: 'bookmark_manager')
      # end
      # result = connection.exec("SELECT * FROM bookmarks WHERE id = #{id};")
      result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
      Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
    end
  end



# Extract the database connection logic to an object, DatabaseConnection.
# Use DatabaseConnection to set up a persistent connection to the correct database, with a method setup.
# Wrap PG's exec method with a method, DatabaseConnection.query, that executes queries on the database.
# Replace Bookmark calls to PG.connect and connection with calls to DatabaseConnection.query.