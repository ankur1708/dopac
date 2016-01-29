json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :mobile, :active, :slug, :user_type, :image
  json.url user_url(user, format: :json)
end
