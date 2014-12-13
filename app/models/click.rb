class Click < ActiveRecord::Base
  belongs_to :url

  def mode_times(mode)
	  mode_return = mode.inject({}) { |k, v| k[v] = mode.count(v); k }
	  mode_return.select { |k,v| v == mode_return.values.max }.keys
	  if mode_return.to_s[2] == "]"
	  	mode_return = mode_return.to_s[1]
	  else
	  	mode_return = mode_return.to_s[1..2]
	  end

	end

  def self.top_five_times(array)
  	top_five_array = []
  	5.times do
  		top_five_array << array.mode_times(array)
  		array.delete_if {|x| x = array.mode_times(array) }
  	end
  	top_five_array
  end

end
