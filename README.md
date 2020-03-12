
# Client -> Controller -> Model -> View

# Controller -> View 

 - At this step we created the Bookmark class and we have refactored the code to call that 
 class and the method self.all.

 Every test is passing at the moment.

 ## INSTRUCTIONS FOR MANAGE SQL DATABASE, USERS.

 1.Connect to psql (\c bookmark_manager;)
 2.Create the database using the psql command CREATE DATABASE bookmark_manager;
 3.Connect to the database using the pqsl command \c bookmark_manager;
 4.Run the query we have saved in the file 01_create_bookmarks_table.sql

 

get '/bookmarks/new' do
  erb :"/bookmarks/new"
end

post '/bookmarks' do
  url = params['url']
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
  redirect '/bookmarks'
end

Get the url from the submitted form data (params).
Connect to the test database.
Execute the SQL to insert a new bookmark to the database, with a url value of the url submitted by the user.
Redirect to the homepage (which shows all bookmarks, thanks to the get '/bookmarks' route defined in app.rb).
