class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :resume, :usertype
  # has_many :interviews
end
