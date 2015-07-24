module VirtualDOM
  module HtmlMethods
    HTML_TAGS.each do |tag_name|
      define_method(tag_name) do |attributes, nodes|
        puts "#{tag_name}"
      end
    end
  end
end
