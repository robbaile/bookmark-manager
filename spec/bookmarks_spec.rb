require 'bookmarks'

describe Bookmarks do 
    it 'should connect to database and have bookmarks added' do 
        connection = PG.connect(dbname: 'bookmark_manager_test')

        # Add the test data
        connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
        connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
        connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

        bookmarks = Bookmarks.all

        expect(bookmarks).to include('http://www.makersacademy.com')
        expect(bookmarks).to include('http://www.destroyallsoftware.com')
        expect(bookmarks).to include('http://www.google.com')
    end

    it 'should add bookmark to the list' do
        connection = PG.connect(dbname: 'bookmark_manager_test')

        Bookmarks.add('http://www.twitter.com')
        bookmarks = Bookmarks.all

        expect(bookmarks).to include('http://www.twitter.com')
    end
end