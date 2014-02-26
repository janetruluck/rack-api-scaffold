require "spec_helper"

describe Api::Users do
  describe "GET /users/me" do
    let!(:user) { create(:user) }

    it "should return user info" do
      get "/users/me", {}, {
        "Accept" => "application/vnd.filmrexx-v1+json",
        "X-Auth-Token" => user.auth_token
      }

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to eq('application/json')
      expect(last_response.body).to eq(user_json(user))
    end

    it "does not retrieve a user without a authenticated user" do
      get "/users/me", {}, {
        "Accept" => "application/vnd.filmrexx-v1+json",
        "X-Auth-Token" => "invalid_user"
      }

      expect(last_response.content_type).to eq('application/json')
      expect(last_response.status).to eq(401)
      expect(last_response.body).to eq({
        "status"      => 401,
        "status_code" => "unauthorized"
      }.to_json)
    end
  end

  describe "GET /users/:id" do
    let!(:user) { create(:user) }

    it "should return user info" do
      get "/users/#{user.uuid}", {}, {
        "Accept" => "application/vnd.filmrexx-v1+json"
      }

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to eq('application/json')
      expect(last_response.body).to eq(user_json(user))
    end

    context "with wrong user_id" do
      it "should not return user info" do
        get "/users/does_not_exist", {}, {
          "Accept" => "application/vnd.filmrexx-v1+json"
        }

        expect(last_response.content_type).to eq('application/json')
        expect(last_response.status).to eq(404)
        expect(last_response.body).to eq({
          "status"      => 404,
          "status_code" => "not_found",
          "error"       => "Record Not Found"
        }.to_json)
      end
    end
  end


  describe "POST /users" do
    let(:params) { attributes_for(:user) }

    it "creates a user" do
      post "/users", { user: params }, {
        "Accept" => "application/vnd.filmrexx-v1+json"
      }

      created_user = User.find_by_email(params[:email])
      expect(created_user.email).to eq(params[:email])

      expect(last_response.content_type).to eq('application/json')
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq(user_json(created_user))
    end

    it "does not create an invalid user" do
      post "/users", {user: {name: ""}}, {
        "Accept" => "application/vnd.filmrexx-v1+json"
      }

      expect(User.all.count).to eq(0)

      expect(last_response.content_type).to eq('application/json')
      expect(last_response.status).to eq(403)
      expect(last_response.body).to eq({
        "status"      => 403,
        "status_code" => "record_invalid",
        "error"       => "Validation failed: email can't be blank",
      }.to_json)
    end
  end
end
