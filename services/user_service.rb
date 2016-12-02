class UserService
  class << self
    def login(username, password)
      user = User.find({username: username})
      raise UnauthorizedError if user.nil?
    end
  end
end