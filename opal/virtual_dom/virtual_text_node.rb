module VirtualDOM
  class VirtualTextNode
    def initialize(text)
      @text = text
    end

    def to_n
      @text.to_s
    end

    def to_s
      @text
    end
  end
end
