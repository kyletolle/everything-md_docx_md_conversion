#!/usr/bin/ruby
input_docx_filename = ARGV[0] || ''
puts "I: #{input_docx_filename}"
output_md_file = ARGV[1] || ''
puts "O: #{output_md_file}"
(puts("Input file name must be given as an arg!") and exit) if input_docx_filename.empty?
(puts("Output file name must be given as an arg!") and exit) if output_md_file.empty?

def build_pandoc_command(input_docx_filename, output_md_file)
  <<CMD
pandoc --filter ./markdown_underscore_italics.rb -s --wrap=none -t gfm -o #{output_md_file} #{input_docx_filename}
CMD
end

# SED_USE_UNDERSCORE_FOR_ITALICS = <<SED.chomp
# 's/ToUnDeRsCoRe/_/g'
# SED
# SED_REPLACE_CURLY_SINGLE_OPEN_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE = <<SED.chomp
# s/\‘/\'/g
# SED
# SED_REPLACE_CURLY_SINGLE_END_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE = <<SED.chomp
# s/\’/\'/g
# SED
# SED_REPLACE_CURLY_DOUBLE_OPEN_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE = <<SED.chomp
# s/\“/\"/g
# SED
# SED_REPLACE_CURLY_DOUBLE_END_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE = <<SED.chomp
# s/\”/\"/g
# SED
# SED_REPLACE_ELLIPSIS_WITH_DOTDOTDOT = <<SED.chomp
# s/…/.../g
# SED
# SED_REPLACE_ESCAPED_EXCLAMATION_POINT_WITH_REGULAR_EXCLAMATION_POINT = <<SED.chomp
# 's/\\\!/\!/g'
# SED
# SED_REPLACE_ESCAPED_HR_WITH_UNESCAPED_HR = <<SED.chomp
# 's/\> \\---/---/'
# SED
# SED_REPLACE_ESCAPED_OPEN_BRACKETS_WITH_UNESCAPED_OPEN_BRACKETS = <<SED.chomp
# 's/\\\[/\[/g'
# SED
# SED_REPLACE_ESCAPED_CLOSE_BRACKETS_WITH_UNESCAPED_CLOSE_BRACKETS = <<SED.chomp
# 's/\\\]/\]/g'
# SED
# SED_ADD_AN_ENDING_NEWLINE_IF_NEEDED = <<SED.chomp
# '$a\'
# SED
SED_USE_UNDERSCORE_FOR_ITALICS = %Q('s/ToUnDeRsCoRe/_/g')
SED_REPLACE_CURLY_SINGLE_OPEN_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE = %Q(s/\\‘/\\'/g)
SED_REPLACE_CURLY_SINGLE_END_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE = %Q(s/\\’/\\'/g)
SED_REPLACE_CURLY_DOUBLE_OPEN_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE = %Q(s/\\“/\\"/g)
SED_REPLACE_CURLY_DOUBLE_END_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE = %Q(s/\\”/\\"/g)
SED_REPLACE_ELLIPSIS_WITH_DOTDOTDOT = %Q(s/…/.../g)
SED_REPLACE_ESCAPED_EXCLAMATION_POINT_WITH_REGULAR_EXCLAMATION_POINT = %Q('s/\\\\\!/\\!/g')
SED_REPLACE_ESCAPED_HR_WITH_UNESCAPED_HR = %Q('s/\> \\---/---/')
SED_REPLACE_ESCAPED_OPEN_BRACKETS_WITH_UNESCAPED_OPEN_BRACKETS = %Q('s/\\\[/\[/g')
SED_REPLACE_ESCAPED_CLOSE_BRACKETS_WITH_UNESCAPED_CLOSE_BRACKETS = %Q('s/\\\]/\]/g')
SED_ADD_AN_ENDING_NEWLINE_IF_NEEDED = %Q('$a\\')
# TODO: Convert en-dash to --
# TODO: Convert em-dash to ---

def build_sed_command(output_md_file)
  <<CMD
sed -i '' -e #{SED_USE_UNDERSCORE_FOR_ITALICS} -e #{SED_REPLACE_CURLY_SINGLE_OPEN_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE} -e #{SED_REPLACE_CURLY_SINGLE_END_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE} -e #{SED_REPLACE_CURLY_DOUBLE_OPEN_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE} -e #{SED_REPLACE_CURLY_DOUBLE_END_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE} -e #{SED_REPLACE_ELLIPSIS_WITH_DOTDOTDOT} -e #{SED_REPLACE_ESCAPED_EXCLAMATION_POINT_WITH_REGULAR_EXCLAMATION_POINT} -e #{SED_REPLACE_ESCAPED_HR_WITH_UNESCAPED_HR} -e #{SED_ADD_AN_ENDING_NEWLINE_IF_NEEDED} -e #{SED_REPLACE_ESCAPED_OPEN_BRACKETS_WITH_UNESCAPED_OPEN_BRACKETS} -e #{SED_REPLACE_ESCAPED_CLOSE_BRACKETS_WITH_UNESCAPED_CLOSE_BRACKETS} #{output_md_file}
CMD
end

_original_command = <<HTML
pandoc --filter ./markdown_underscore_italics.rb  -s --wrap=none -t gfm -o ch2/index.with-pandoc.md ch2/ch2.with-pandoc.docx && sed -i '' -e 's/ToUnDeRsCoRe/_/g' -e s/\’/\'/g -e s/\“/\"/g -e s/\”/\"/g -e s/…/.../g -e 's/\\\!/\!/g' -e 's/\> \\---/---/' -e '$a\' ch2/index.with-pandoc.md
HTML

def execute_command_for(input_docx_filename, output_md_file)
  pandoc_cmd = build_pandoc_command(input_docx_filename, output_md_file)
  sed_cmd = build_sed_command(output_md_file)

  puts "Pandoc command:"
  puts pandoc_cmd
  `#{pandoc_cmd}`
  puts "Sed command:"
  puts sed_cmd
  `#{sed_cmd}`

end

execute_command_for(input_docx_filename, output_md_file)
