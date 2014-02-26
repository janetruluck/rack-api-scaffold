module Api
  class Root < Grape::API
    version 'v1', using: :header, vendor: "your_api"
    format :json

    rescue_from ActiveRecord::RecordNotFound do |e|
      message = "Record Not Found"
      Rack::Response.new(
        [{ status: 404, status_code: "not_found", error: message }.to_json],
        404,
        { 'Content-Type' => 'application/json' }
      )
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      message = e.message.downcase.capitalize
      Rack::Response.new(
        [{ status: 403, status_code: "record_invalid", error: message }.to_json],
        403,
        { 'Content-Type' => 'application/json' }
      )
    end

    module CurrentResources
      def current_user
        @current_user ||= User.authenticate(env["X-Auth-Token"])
      end
    end

    module Auth
      def authenticate!
        error!({status: 401, status_code: 'unauthorized'}, 401) unless current_user
      end
    end

    helpers Api::Root::CurrentResources
    helpers Api::Root::Auth

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    mount Api::Status
    mount Api::Users

    route :any, "*path" do
      error!("404 Not Found", 404)
    end
  end
end

