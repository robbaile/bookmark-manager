require 'pg'

class Bookmarks
    
    attr_reader :id, :title, :url

    def initialize(id:, title:, url:)
      @id  = id
      @title = title
      @url = url
    end

    def self.all
        connection = connect
        result = connection.exec("SELECT * FROM bookmarks;")
        result.map do |bookmark|
            Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
        end
    end

    def self.add(url, title)
        connection = connect
        connection.exec("INSERT into bookmarks (url, title) values ($1, $2) RETURNING id, url, title;", [url, title])
    end

    private

    def self.connect
        db_name = ENV['RACK_ENV'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
        return PG.connect(dbname: db_name) 
    end
end