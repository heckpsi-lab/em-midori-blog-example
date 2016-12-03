class UserService
  class << self
    def login(username, password)
      user = User.find(username: username, password: password)
      raise UnauthorizedError if user.nil?
      token = SecureRandom.uuid62
      user.add_token(token: token)
      {code: 200,
       result: {
           user_id: user.id,
           token: token
       }}
    end

    def register(username, password)
      user = User.find(username: username)
      raise ResourceConflict unless user.nil?
      User.create(username: username, password: password)
      {code: 201}
    end

    def auth!(token, user_id = nil)
      user = Token.find({token: token})&.user
      raise UnauthorizedError if user.nil?
      raise UnauthorizedError unless user_id.nil? || user.id == user_id
      user
    end
  end
end