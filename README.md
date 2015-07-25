# Virtual Dom support for Opal
[![Gem Version](https://badge.fury.io/rb/opal-virtual-dom.svg)](http://badge.fury.io/rb/opal-virtual-dom)
[![Code Climate](https://codeclimate.com/github/fazibear/opal-virtual-dom/badges/gpa.svg)](https://codeclimate.com/github/fazibear/opal-virtual-dom)

## requiments

This wrapper require to load [virtual-dom](https://github.com/Matt-Esch/virtual-dom) first. For example you can use rails assets.

```ruby
source 'https://rails-assets.org' do
  gem 'rails-assets-virtual-dom'
end
```

## usage

Server side (config.ru, Rakefile, Rails, Sinatra, etc.)

```ruby
require 'opal-virtual-dom'
```

Browser side

```ruby
require 'opal'
require 'virtual-dom' # javascript library
require 'browser'     # not required
require 'virtual_dom' # opal wrapper

class SampleList
  include VirtualDOM

  attr_reader :elements

  def initialize(elements = [])
    @elements = elements
  end

  def render
    virtual_dom do
      ul class: 'simple-list' do
        elements.each do |string|
          li string
        end
      end
    end
  end
end

$document.ready do
  list = SampleList.new(%w(one two three)).render
  back = SampleList.new(%w(three two one)).render

  root_node = VirtualDOM.create(list)
  $document.body.inner_dom = root_node

  diff = VirtualDOM.diff(list, back)
  VirtualDOM.patch(root_node, diff)
end
```
