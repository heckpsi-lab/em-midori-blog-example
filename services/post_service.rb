class PostService
  class << self
    def request_post(id)
      post = Post.find(id: id)
      raise Midori::Exception::NotFound if post.nil?
      {code: 200, result: post['content']}
    end

    def request_post_source(id)
      post = Post.find(id: id)
      raise Midori::Exception::NotFound if post.nil?
      {code: 200, result: post['source']}
    end

    def create_post(user, title, source)
      user.add_post(title: title,
                    source: source,
                    content: Kramdown::Document.new(source).to_html,
                    created_at: DateTime.now)
      {code: 201}
    end
  end
end