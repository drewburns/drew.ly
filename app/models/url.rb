
class Url < ActiveRecord::Base
  validates :original_url, format: { with: /https?:\/\/\w+.\w{3}/,}
  validates	:shortened_url , uniqueness: true
  has_many :clicks



  def self.random_string
		random_url = ""
		letters_and_numbers = "abcdefghijklmnopqrstuvwxyz0123456789"
			6.times do
				random_url += letters_and_numbers[rand(letters_and_numbers.length)]
			end
		random_url
	end
end