class UserRoute < Midori::API
  post '/login' do

  end

  post '/register' do

  end

  get '/:username' do
    # View User Profile
    set_cookie('test', 'test')
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