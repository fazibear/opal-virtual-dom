require 'bundler'
Bundler.require
Bundler::GemHelper.install_tasks

require 'open-uri'

desc 'Update JS dependencies'
task :js_deps do
  js_lib_url = 'https://raw.githubusercontent.com/Matt-Esch/virtual-dom/master/dist/virtual-dom.js'
  js_lib_dest = File.join(File.dirname(__FILE__), './opal/vendor/virtual-dom.js')
  open(js_lib_url) do |f|
    File.write(js_lib_dest, f.readlines.join)
  end
end
