module VirtualDOM
  class NodeFactory
    attr_reader :nodes

    def initialize(dom)
      @nodes = []
      @eval = instance_eval(&dom)
    end

    def method_missing(name, *args, &block)
      @nodes << if name == 'text'
                  VirtualTextNode.new(args.first).vnode
                else
                  VirtualNode.new(name, params(args), childrens(args, block)).vnode
                end
    end

    def params(args)
      if args.first.is_a?(Hash)
        args = args.first
        args['className'] = args.delete('class') if args.keys.include?('class')
        args
      else
        {}
      end
    end

    def childrens(args, block)
      if block
        NodeFactory.new(block).nodes
      elsif args.last.is_a?(String)
        [VirtualTextNode.new(args.last).vnode]
      else
        []
      end
    end
  end
end
