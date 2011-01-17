#!/usr/bin/env ruby

ROOT_DIR_RELATIVE_PATH = '../'

def chdir_to_root_dir
  Dir.chdir File.join(File.expand_path(File.dirname(__FILE__)),
                      ROOT_DIR_RELATIVE_PATH)
end

# script's entry point
# community  links  news  solution  stories
category = case ARGV[0]
when /community/i
  'community'
when /links/i
  'links'
when /news/i
  'news'
when /solution/i
  'solution'
else
  # show last_id and exit
  nil
end

puts "category = #{category}"

# change dir to the site's root dir
chdir_to_root_dir
puts 'root_dir = ' + Dir.pwd

#files = Dir.glob('**/*-id-*')
ids = Dir.glob('**/*-id-*').map do |f|
  ($1).to_i if File.basename(f, '.*') =~ /id-(\d+)/
end

ids.sort!
last_id = ids[-1] || 0
last_id = last_id + 1

puts "last_id = #{last_id}"
exit unless category

filename = Time.now.strftime("%Y-%m-%d-id-") +  "%05d" % last_id + ".md"
puts "filename = #{filename}"

fullpath = File.join(Dir.pwd, '_posts', category, filename)
puts "fullpath = #{fullpath}"

# ---
#title: Молитва Нашей Шаговой Группы
#layout: post
#category: solution
#tags: [ Молитвы ]
#author:
#---
File.open(fullpath, 'w') do |f|
  f.puts "---"
  f.puts "title: "
  f.puts "layout: post"
  f.puts "category: #{category}"
  f.puts "tags: [  ]"
  f.puts "author:"
  f.puts "---"
  f.puts
  f.puts
end

# vim: set sts=2 sw=2 et:
