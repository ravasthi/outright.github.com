#!/usr/bin/env ruby

require 'stringex'

title = ARGV.first
date = Time.now.strftime("%Y-%m-%d")
file_name = "#{date}-#{title.to_url}.md"
if File.exist?(File.join("_posts", file_name))
  abort("rake aborted!") if ask("#{file_name} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
end

File.open(File.join("_posts", file_name), 'w') do |f|
  f.puts "---"
  f.puts "layout: post"
  f.puts "title: #{title}"
  f.puts "date: #{date}"
  f.puts "author: #{ENV['USER']}"
  f.puts "css_id: "
  f.puts "css_classes: [ permalink ]"
  f.puts "---"
end

puts "Created #{file_name}"
