class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile, :active, :slug, :user_type, :image
end
