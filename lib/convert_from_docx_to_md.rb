#!/usr/bin/ruby

require_relative 'first_way_of_doing_things'
require_relative 'second_way_of_doing_things'

input_docx_filename = ARGV[0] || ''
puts "I: #{input_docx_filename}"
output_md_file = ARGV[1] || ''
puts "O: #{output_md_file}"
(puts("Input file name must be given as an arg!") and exit) if input_docx_filename.empty?
(puts("Output file name must be given as an arg!") and exit) if output_md_file.empty?

_original_command = <<HTML
pandoc --filter ./markdown_underscore_italics.rb  -s --wrap=none -t gfm -o ch2/index.with-pandoc.md ch2/ch2.with-pandoc.docx && sed -i '' -e 's/ToUnDeRsCoRe/_/g' -e s/\’/\'/g -e s/\“/\"/g -e s/\”/\"/g -e s/…/.../g -e 's/\\\!/\!/g' -e 's/\> \\---/---/' -e '$a\' ch2/index.with-pandoc.md
HTML

SecondWayOfDoingThings.new(input_docx_filename, output_md_file).run
