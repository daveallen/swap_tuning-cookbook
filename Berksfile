# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

source 'https://supermarket.getchef.com'
my_cookbook = ::File.basename(Dir.pwd).sub(/[-_]?cookbook$/, '')

# Helper to include a local cookbook from disk
def local_cookbook(name, version = '>= 0.0.0', options = {})
  cookbook(name, version, {
    path: "../../cookbooks/#{name}"
  }.merge(options))
end

metadata

# Required for ChefSpec matchers
cookbook 'swap', '>= 0.3.8'

# Minitest Chef Handler
# More info at https://github.com/calavera/minitest-chef-handler
if ::File.directory?(::File.join('files', 'default', 'tests', 'minitest')) ||
   ::File.directory?(::File.join(
     'test', 'cookbooks', "#{my_cookbook}_test", 'files', 'default', 'tests',
     'minitest'
   ))
  cookbook 'minitest-handler'
end

# Integration tests cookbook:
if ::File.directory?("./test/cookbooks/#{my_cookbook}_test")
  cookbook "#{my_cookbook}_test", path: "./test/cookbooks/#{my_cookbook}_test"
end
