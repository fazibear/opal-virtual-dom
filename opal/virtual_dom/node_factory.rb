module VirtualDOM
  class NodeFactory
    attr_reader :nodes

    def initialize(dom, _self)
      @nodes = []
      @self = _self
      instance_eval(&dom)
    end

    def method_missing(name, *args, &block)
      if @self.send(:respond_to?, name)
        @self.send(name, *args, &block)
      elsif name == 'text'
        @nodes << VirtualTextNode.new(args.first).vnode
      elsif HTML_TAGS.include?(name)
        @nodes << VirtualNode.new(name, params(args), childrens(args, block)).vnode
      else
        super
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
        NodeFactory.new(block, @self).nodes
      elsif args.last.is_a?(String)
        [VirtualTextNode.new(args.last).vnode]
      else
        []
      end
    end

    HTML_TAGS = %w(
      a abbr address area article aside audio
      b base bdi bdo blockquote body br button
      canvas caption cite code col colgroup command
      data datalist dd del details dfn dialog div dl dt
      em embed
      fieldset figcaption figure footer form
      h1 h2 h3 h4 h5 h6 head header hgroup hr html
      i iframe img input ins
      kbd keygen
      label legend li link
      map mark menu meta meter
      nav noscript
      object ol optgroup option output
      p param pre progress
      q
      rp rt ruby
      s samp script section select small source span strong style sub summary sup
      table tbody td textarea tfoot th thead time title tr track
      u ul
      vav video
      wbr
    )
  end
end
