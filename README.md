# Virtual Dom support for Opal
[![Gem Version](https://badge.fury.io/rb/opal-virtual-dom.svg)](http://badge.fury.io/rb/opal-virtual-dom)
[![Code Climate](https://codeclimate.com/github/fazibear/opal-virtual-dom/badges/gpa.svg)](https://codeclimate.com/github/fazibear/opal-virtual-dom)

## Description

Opal wrapper for [virtual-dom](https://github.com/Matt-Esch/virtual-dom) javascript library. For more information see [virtual-dom wiki page](https://github.com/Matt-Esch/virtual-dom/wiki).

## Usage

Server side (config.ru, Rakefile, Rails, Sinatra, etc.)

```ruby
require 'opal-virtual-dom'
```

Browser side

```ruby
require 'opal'
require 'browser'     # not required
require 'virtual_dom'

# if you're using broser and you want to have events and elements wrapped
require 'virtual_dom/support/browser'

class SampleList
  include VirtualDOM

  def initialize(elements = [])
    @elements = elements
  end

  def create_hook(node, name, previous)
    puts "I'm created: #{node}"
  end

  def render
    # You can use chained methods
    # to add class to elements
    # use bang method to define element id

    p.id! do
      ul.simple_list.list(hook: Hook.method(method(:create_hook))) do
        @elements.each do |string|
          li do
            text string
          end
        end
      end
    end
  end
end

$document.ready do
  list = SampleList.new(%w(one two three)).render.to_vnode
  back = SampleList.new(%w(three two one)).render.to_vnode

  root_node = VirtualDOM.create(list)
  $document.body.inner_dom = root_node

  diff = VirtualDOM.diff(list, back)
  VirtualDOM.patch(root_node, diff)
end
```
