require 'sinatra/base'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base

    enable :sessions
    
    get '/' do 
        erb(:index)
    end

    get '/bookmarks' do 
        @bookmarks = Bookmarks.all
        erb(:bookmarks)
    end

    post '/bookmarks' do 
        Bookmarks.add(params['url'])
        redirect('/bookmarks')
    end
end