module VirtualDOM
  module ExternalSupport
    module_function

    def wrap_node(node)
      Browser::DOM::Element.new(node)
    end

    def wrap_event(event)
      Browser::Event.new(event)
    end
  end
end
