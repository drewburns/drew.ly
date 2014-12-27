class User < ActiveRecord::Base
	validates	:username , uniqueness: true
	# validates :email , uniqueness: true , format: { with: /\w+@\w+.\w+/}
  has_many :urls
end
