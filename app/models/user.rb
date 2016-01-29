class User < ActiveRecord::Base
	has_many :messages

	def generate_slug (user)
		o = [('a'..'z'), (1..9), ('A'..'Z')].map { |i| i.to_a }.flatten
		string = (0...8).map { o[rand(o.length)] }.join
		return user.name.gsub(' ', '-') + '-' + user.id.to_s + string
	end

end
