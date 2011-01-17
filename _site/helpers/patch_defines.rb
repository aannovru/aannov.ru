#!/usr/bin/env ruby

require 'tempfile'

ROOT_DIR_RELATIVE_PATH = '../'
DEFINES_FILE = '_includes/defines.html'
FILES = %w(
  _layouts/post.html
  community/index.html
  links/index.html
  news/index.html
  solution/index.html
  stories/index.html
  index.html
)

def chdir_to_root_dir
  Dir.chdir File.join(File.expand_path(File.dirname(__FILE__)),
                      ROOT_DIR_RELATIVE_PATH)
end

def patch_file defines_contents, filename
  f = Tempfile.new('ruby_helpers')
  puts "Processing: " + filename
  puts "temp file = #{f.path}"
  defines_contents.each { |line| f.puts line }
  found = false
  File.readlines(filename).each { |line|
    next unless line =~ /^private:/ or found
    # MP: UGLY
    found = true
    f.puts line.chop!
  }
  File.rename(f.path, filename)
  f.delete  
end

# script's entry point
# change dir to the site's root dir
chdir_to_root_dir
puts 'root_dir = ' + Dir.pwd
puts 'defines_file = ' + DEFINES_FILE
puts 'files to patch:'
FILES.each { |f| puts f }

defines_contents = [ '---' ]

File.readlines(DEFINES_FILE).each { |line|
  defines_contents << line.chop! unless line =~ /^---/
}

#defines_contents.each { |s| puts s }
FILES.each { |file| patch_file defines_contents, file }


# vim: set sts=2 sw=2 et:
