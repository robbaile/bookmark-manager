require 'pg'

feature 'Bookmark' do 
    scenario 'Loads the index view' do 
        visit('/')
        expect(page).to have_content "Hello world"
    end

    
    scenario 'A user can see bookmarks' do
        connection = PG.connect(dbname: 'bookmark_manager_test')

        Bookmarks.add('http://www.makersacademy.com', 'Makers Academy')
        Bookmarks.add('http://www.destroyallsoftware.com', 'Destroy All Software')
        Bookmarks.add('http://www.google.com', 'Google')
    
        visit '/bookmarks'
    
        expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
        expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
        expect(page).to have_link('Google', href: 'http://www.google.com')
    end

    scenario 'add a bookmark to the list' do 
        visit('/bookmarks')
        fill_in('url', :with => "http://www.twitter.com")
        fill_in('title', with: 'Test Bookmark')
        click_button "submit"
        have_link('Test Bookmark', href: "http://www.twitter.com")
    end
end
