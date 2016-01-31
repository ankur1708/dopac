class User < ActiveRecord::Base
	after_create :set_slug
	has_many :messages


	def set_slug
		o = [('a'..'z'), (1..9), ('A'..'Z')].map { |i| i.to_a }.flatten
		string = (0...8).map { o[rand(o.length)] }.join
		self.slug =  name.gsub(' ', '-') + '-' + id.to_s + string
		self.save
    end

end
