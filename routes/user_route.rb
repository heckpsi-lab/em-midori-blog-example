class UserRoute < Midori::API
  post '/' do
    # Login
    req = JSON.parse(request.body)
    result = UserService.login(req['username'], req['password'])
    set_cookie('token', result[:result][:token])
    result.to_json
  end

  put '/' do
    # Register
    req = JSON.parse(request.body)
    UserService.register(req['username'], req['password']).to_json
  end

  get '/:username' do
    # View User Profile
    UserService.auth!(get_cookie('token'))
    'test'
  end

  post '/:username' do
    # Create User
  end

  put '/:username' do
    # Update User
  end

  delete '/:username' do
    # Delete User
  end
end