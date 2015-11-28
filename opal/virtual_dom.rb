require 'vendor/virtual-dom'
require 'virtual_dom/virtual_node'
require 'virtual_dom/wrapper'
require 'virtual_dom/dom'

module VirtualDOM
  include VirtualDOM::DOM
  extend VirtualDOM::Wrapper
end
