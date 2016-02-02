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
require 'virtual-dom'

class SampleList
  include VirtualDOM

  def initialize(elements = [])
    @elements = elements
  end

  def render
    ul class: 'simple-list' do
      @elements.each do |string|
        li do
          text string
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
