require 'sinatra/base'

class App < Sinatra::Application

  URL_ARRAY = []
  URL_ERROR = false

  get '/' do
    if URL_ERROR
      erb :index, locals: {:error => URL_ERROR[:error_text], :url_value => URL_ERROR[:bad_url]}
    else
      erb :index, locals: {:error => nil, :url_value => ""}
    end
  end

  post '/' do
    if params[:url_input] =~ URI::regexp(["ftp", "http", "https"])
      URL_ERROR = false
      current_index = (URL_ARRAY.length + 1).to_s
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
      new_url = @base_url + '/' + current_index
      URL_ARRAY << {:old => params[:url_input], :new => new_url}
      redirect '/' + current_index + '?stats=true'
    else
      URL_ERROR = {error_text: "The text you entered is not a valid URL", bad_url: params[:url_input]}
      redirect '/'
    end

  end

  get '/:id' do
    url_pairs = URL_ARRAY[params[:id].to_i - 1]
    if params[:stats] == 'true'
      erb :show_urls, locals: {:urls => url_pairs}
    else
      redirect url_pairs[:old]
    end
  end

  #"http://google.com" =~ URI::regexp(["ftp", "http", "https"])

end