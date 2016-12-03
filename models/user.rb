class User < Sequel::Model
  one_to_many :posts
  one_to_many :tokens
end