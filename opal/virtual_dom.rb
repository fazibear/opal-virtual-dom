require 'virtual_dom/virtual_node'
require 'virtual_dom/virtual_text_node'
require 'virtual_dom/node_factory'

module VirtualDOM
  def virtual_dom(&block)
    NodeFactory.new(block).nodes
  end

  module_function

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
