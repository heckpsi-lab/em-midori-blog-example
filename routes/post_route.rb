class PostRoute < Midori::API
  get '/:post_id' do
    # View a Post
  end

  post '/:post_id' do
    # Create a new Post
  end

  put '/:post_id' do
    # Modify a Post
  end

  delete '/:post_id' do
    # Delete a Post
  end
end