module VirtualDOM
  class CommonHook
    def self.method(mthd)
      new do |node, name, previous|
        mthd.call(node, name, previous)
      end
    end

    def initialize(&block)
      @block = block
    end

    def to_n
      self
    end

    def call_block(node, name, previous)
      node = Support.wrap_node(node)
      name = Native(name)
      previous = Native(previous)
      @block.call(node, name, previous)
    end
  end

  class Hook < CommonHook
    %x{
      Opal.defn(self, 'hook', function(node, name, previous) {
        var self = this;
        #{call_block(`node`, `name`, `previous`)};
      });
      Opal.defn(self, 'unhook', function(node, name, previous) {});
    }
  end

  class UnHook < CommonHook
    %x{
      Opal.defn(self, 'unhook', function(node, name, previous) {
        var self = this;
        #{call_block(`node`, `name`, `previous`)};
      });
      Opal.defn(self, 'hook', function(node, name, previous) {});
    }
  end
end
