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
        process_tag(tag, params, block)
      end
    end

    def process_tag(tag, params, block)
      @__virtual_nodes__ ||= []
      if block
        current = @__virtual_nodes__
        @__virtual_nodes__ = []
        result = block.call || ''
        vnode = VirtualNode.new(tag, process_params(params), @__virtual_nodes__.count.zero? ? result : @__virtual_nodes__)
        @__virtual_nodes__ = current
      elsif params.is_a?(String)
        vnode = VirtualNode.new(tag, {}, [params])
      else
        vnode = VirtualNode.new(tag, process_params(params), [])
      end
      @__last_virtual_node__ = vnode
      @__virtual_nodes__ << to_vnode
      self
    end

    def method_missing(clazz, params = {}, &block)
      @__virtual_nodes__.pop
      class_params = @__last_virtual_node__.params.delete(:className)
      method_params = if clazz.end_with?('!')
                        { id: clazz[0..-2],
                          class: merge_string(class_params, params[:class]) }
                      else
                        { class: merge_string(class_params, params[:class], clazz) }
                      end
      params = @__last_virtual_node__.params.merge(params).merge(method_params)
      process_tag(@__last_virtual_node__.name, params, block)
    end

    def merge_string(*params)
      arr = []
      params.each do |string|
        next unless string
        arr << string.split(' ')
      end
      arr.join(' ')
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

    def to_vnode
      @__last_virtual_node__.to_n
    end
  end
end
