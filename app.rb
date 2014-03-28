require 'sinatra/base'

class App < Sinatra::Application

  URL_ARRAY = []

  get '/' do
    erb :index
  end

  post '/' do
    current_index = (URL_ARRAY.length + 1).to_s
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    new_url = @base_url + '/' + current_index
    URL_ARRAY << {:old => params[:url_input], :new => new_url}
    redirect '/' + current_index + '?stats=true'
  end

  get '/:id' do
    url_pairs = URL_ARRAY[params[:id].to_i - 1]
    if params[:stats] == 'true'
      erb :show_urls, locals: {:urls => url_pairs}
    else
      redirect url_pairs[:old]
    end
  end

end