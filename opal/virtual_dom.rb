require 'virtual_dom/virtual_node'
require 'virtual_dom/virtual_text_node'
require 'virtual_dom/node_factory'
require 'virtual_dom/methods'
require 'virtual_dom/html_tags'
require 'virtual_dom/html_methods'

module VirtualDOM
  extend Methods
  include HtmlMethods
end
