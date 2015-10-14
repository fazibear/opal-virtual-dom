module VirtualDOM
  module Wrapper
    def create(vnode)
      `virtualDom.create(#{vnode})`
    end

    def diff(old, new)
      `virtualDom.diff(#{old}, #{new})`
    end

    def patch(dom, diff)
      `virtualDom.patch(#{dom}, #{diff})`
    end
  end
end
