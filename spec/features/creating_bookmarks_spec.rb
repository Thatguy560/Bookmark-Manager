# As a user
# So I can store bookmark data for later retrieval
# I want to add a bookmark to Bookmark Manager

feature 'Adding a new bookmark' do
    scenario 'A user can add a bookmark to Bookmark Manager' do
      visit('/bookmarks/new')
      fill_in('url', with: 'http://www.testbookmark.com')
      fill_in('title', with: 'Test Bookmark')
      click_button('Submit')
      # Now we have updated this filepath with a new link where we can
      # add bookmarks to Bookmark manager.
      expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
    end
  end





# Visiting a page, /bookmarks/new (Update your app.rb 'controller' 
#file so we now have a new file path, then we'll create a new
# erb filepath in the views directory so we can view the content.)

# Typing a URL into a form on that page
# Submitting the form
# Seeing the bookmark they just submitted.