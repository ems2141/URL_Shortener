require 'sinatra/base'

class App < Sinatra::Application

  URL_ARRAY = []

  get '/' do
    erb :index
  end

  post '/' do
    current_index = (URL_ARRAY.length+1).to_s
    new_url = "http://stormy-inlet-1672.herokuapp.com/" + current_index
    URL_ARRAY << {:old => params[:url_input], :new => new_url}
    redirect '/' + current_index + '?stats=true'
  end

  get '/:id' do
    url_pairs = URL_ARRAY[params[:id].to_i - 1]
    erb :show_urls, locals:{:urls => url_pairs}
  end

end