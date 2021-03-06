class PostRoute < Midori::API
  get '/:post_id' do
    # View a Post
    PostService.read_post(request.param['post_id']).to_json
  end

  get '/:post_id/source' do
    # View a Post Source
    PostService.read_post_source(request.param['post_id']).to_json
  end

  post '/:post_id' do
    # Create a new Post
    user = UserService.auth!(get_cookie('token'))
    req = JSON.parse request.body
    status = 201
    PostService.create_post(user, req['title'], req['source']).to_json
  end

  put '/:post_id' do
    # Modify a Post
  end

  delete '/:post_id' do
    # Delete a Post
  end
end