class Array

  def mappa(&block)
    if block_given?
      i = 0
      while i < self.length
        self[i] = block.call(self[i])
        i += 1
      end
    end
  end

end