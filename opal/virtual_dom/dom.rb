module VirtualDOM
  module DOM
    HTML_TAGS = %w(a abbr address area article aside audio b base bdi bdo big blockquote body br
                  button canvas caption cite code col colgroup data datalist dd del details dfn
                  dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5
                  h6 head header hr html i iframe img input ins kbd keygen label legend li link
                  main map mark menu menuitem meta meter nav noscript object ol optgroup option
                  output p param picture pre progress q rp rt ruby s samp script section select
                  small source span strong style sub summary sup table tbody td textarea tfoot th
                  thead time title tr track u ul var video wbr)

    HTML_TAGS.each do |tag|
      define_method tag do |params = {}, &block|
        @__virtual_nodes__ ||= []
        if block
          current = @__virtual_nodes__
          @__virtual_nodes__ = []
          result = block.call || ''
          vnode = VirtualNode.new(tag, process_params(params), @__virtual_nodes__.count == 0 ? result : @__virtual_nodes__).to_n
          @__virtual_nodes__ = current
        else
          vnode = VirtualNode.new(tag, process_params(params), []).to_n
        end
        @__virtual_nodes__ << vnode
        vnode
      end
    end

    def process_params(params)
      return {} unless params.is_a?(Hash)
      params.dup.each do |k, v|
        case k
        when 'class'
          params['className'] = params.delete('class')
        when 'data'
          params['dataset'] = params.delete('data')
        when 'default'
          params['defaultValue'] = params.delete('default')
        when /^on/
          params[k] = event_callback(v)
        end
      end
      params
    end

    def event_callback(v)
      proc do |e|
        v.call(Support.wrap_event(e))
      end
    end

    # for backwards compatibility, you can return string
    def text(string)
      @__virtual_nodes__ << string.to_s
    end

    # for backwards compatibility
    def virtual_dom(&block)
      block.call
    end
  end
end
