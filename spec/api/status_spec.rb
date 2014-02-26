require "spec_helper"

describe Api::Status do
  describe "GET /status" do
    it "returns OK" do
      get "/status", {}, { "Accept" => "application/vnd.filmrexx-v1+json" }

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ 'status' => 'ok' }.to_json)
      expect(last_request.env["Accept"]).to eq("application/vnd.filmrexx-v1+json")
    end
  end
end
