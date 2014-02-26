module Api
  class Status < Grape::API
    desc "Returns the status of the API"
    get '/status' do
      { status: 'ok' }
    end
  end
end
