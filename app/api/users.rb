module Api
  class UserEntity < Grape::Entity
    expose :uuid, as: :id
    expose :email
    expose :auth_token
  end

  class Users < Grape::API
    desc "Returns user details for the authenticated user"
    get '/users/me' do
      authenticate!
      present current_user, with: Api::UserEntity
    end

    desc "Returns user details for the requested user"
    params do
      requires :id, type: String, desc: "The users ID"
    end
    get '/users/:id' do
      user = User.find_by_uuid!(params[:id])
      present user, with: Api::UserEntity
    end

    desc "Creates a user"
    params do
      requires :user, type: Hash, desc: "User attributes"
    end
    post '/users' do
      user = User.new(params[:user])
      user.password = params[:password]
      user.save!
      present user, with: Api::UserEntity
    end
  end
end
