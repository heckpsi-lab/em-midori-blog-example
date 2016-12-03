class PostRoute < Midori::API
  get '/:post_id' do
    # View a Post
    status = 201
    PostService.request_post(request.param['post_id']).to_json
  end

  post '/:post_id' do
    # Create a new Post
    UserService.auth!(get_cookie('token'))
    req = JSON.parse request.body
    PostService.create_post(get_cookie('token'), req['title'], req['source']).to_json
  end

  put '/:post_id' do
    # Modify a Post
  end

  delete '/:post_id' do
    # Delete a Post
  end
end