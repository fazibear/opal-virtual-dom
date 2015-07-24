module VirtualDOM
  class VirtualNode
    def initialize(name, params = {}, childrens = [])
      @name = name
      @params = params
      @childrens = childrens
    end

    def vnode
      `virtualDom.h(#{@name}, #{@params.to_n}, #{@childrens})`
    end

    def to_s
      "<#{@name}#{to_s_params}>#{@childrens.map(&:to_s).join}</#{@name}>"
    end

    def to_s_params
      if @params.any?
        " " + @params.map do |k,v|
          "#{k}=\"#{v}\""
        end.join(' ')
      end
    end
  end
end
