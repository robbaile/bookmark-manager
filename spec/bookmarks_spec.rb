require 'bookmarks'

describe Bookmarks do 
    it 'returns a list of bookmarks' do
        connection = PG.connect(dbname: 'bookmark_manager_test')
     
        # Add the test data
        Bookmarks.add("http://www.makersacademy.com", "Makers Academy")
        Bookmarks.add("http://www.destroyallsoftware.com", "Destroy All Software")
        Bookmarks.add("http://www.google.com", "Google")
     
        bookmarks = Bookmarks.all
     
        expect(bookmarks.length).to eq 3
        expect(bookmarks.first).to be_a Bookmarks
        expect(bookmarks.first.title).to eq 'Makers Academy'
        expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end

    it 'should add bookmark to the list' do
        connection = PG.connect(dbname: 'bookmark_manager_test')

        Bookmarks.add('http://www.twitter.com', 'New Bookmark')
        bookmarks = Bookmarks.all

        expect(bookmarks.first.title).to eq 'New Bookmark'
    end
end