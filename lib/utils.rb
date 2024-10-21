
module Utils
  def self.arr_to_hash arr
    Hash[*(arr.map{|e| e.split(": ", 2)}.flatten)]
  end
end