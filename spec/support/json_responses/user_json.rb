def user_json(user)
  {
    'id'    => user.uuid,
    'email'  => user.email,
    'auth_token'  => user.auth_token,
  }.to_json
end
