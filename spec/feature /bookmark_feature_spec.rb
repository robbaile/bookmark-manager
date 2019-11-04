require 'pg'

feature 'Bookmark' do 
    scenario 'Loads the index view' do 
        visit('/')
        expect(page).to have_content "Hello world"
    end

    
    scenario 'A user can see bookmarks' do
        connection = PG.connect(dbname: 'bookmark_manager_test')

        # Add the test data
        connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
        connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
        connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")

        visit('/bookmarks')

        expect(page).to have_content "http://www.makersacademy.com"
        expect(page).to have_content "http://www.destroyallsoftware.com"
        expect(page).to have_content "http://www.google.com"
    end

    scenario 'add a bookmark to the list' do 
        visit('/bookmarks')
        fill_in('url', :with => "http://www.twitter.com")
        click_button "submit"
        expect(page).to have_content "http://www.twitter.com"
    end
end
