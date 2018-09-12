require 'sinatra'
require 'net/http'
require 'json'
require 'pry'

get '/' do
  base = params[:base] || "USD"
  url = "https://api.exchangeratesapi.io/latest?base=#{base}"
  @currencies = %w(USD EUR GBP)
  target = get_data_from url
  @rates = @target["rates"]

  if request.xhr?
    format.json {
      render json:{
        rates: @rates
      }
    }
  end
  haml :index

end

def get_data_from url
  uri = URI(url)
  response = Net::HTTP.get(uri)

  JSON.parse(response)
end
