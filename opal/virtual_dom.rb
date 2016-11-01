require 'vendor/virtual-dom'
require 'virtual_dom/dom'
require 'virtual_dom/virtual_node'
require 'virtual_dom/wrapper'
require 'virtual_dom/hook'
require 'virtual_dom/support'

module VirtualDOM
  include VirtualDOM::DOM
  extend VirtualDOM::Wrapper
end
