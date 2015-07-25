module VirtualDOM
  class NodeFactory
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
      param pre progress
      q
      rp rt ruby
      s samp script section select small source span strong style sub summary sup
      table tbody td textarea tfoot th thead time title tr track
      u ul
      vav video
      wbr
    )

    attr_reader :nodes

    def initialize(dom, parent)
      @nodes = []
      @parent = parent
      instance_eval(&dom)
    end

    HTML_TAGS.each do |tag|
      define_method tag do |params, &block|
        @nodes << VirtualNode.new(
          tag,
          process_params(params),
          block ? NodeFactory.new(block, @parent).nodes : []
        ).vnode
      end
    end

    def text(string)
      @nodes << VirtualTextNode.new(string).vnode
    end

    def method_missing(name, *args, &block)
      if @parent.send(:respond_to?, name)
        @parent.send(name, *args, &block)
      else
        super
      end
    end

    def process_params(params)
      if params && params.is_a?(Hash)
        params['className'] = params.delete('class') if params.keys.include?('class')
        params
      else
        {}
      end
    end
  end
end
