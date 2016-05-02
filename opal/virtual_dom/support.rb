module VirtualDOM
  module Support
    module_function

    def wrap_node(node)
      Native(node)
    end

    def wrap_event(event)
      Native(event)
    end
  end
end
