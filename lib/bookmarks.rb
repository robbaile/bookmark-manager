require 'pg'

class Bookmarks
    
    def self.all
        connection = connect
        result = connection.exec("SELECT * FROM bookmarks;")
        result.map { |row| row['url'] }
    end

    def self.add(url)
        connection = connect
        connection.exec("INSERT into bookmarks (url) values ($1::text);", [url])
    end

    private

    def self.connect
        db_name = ENV['RACK_ENV'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
        return PG.connect(dbname: db_name) 
    end
end