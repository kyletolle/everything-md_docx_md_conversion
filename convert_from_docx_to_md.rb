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
# Note: These sed regexes are ugly because we have to escape special characters.
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

class MarkdownText
  attr_accessor :initial_text

  def initialize(initial_text)
    self.initial_text = initial_text
  end

  def modified_text
    modified_text = initial_text

    modification_methods.each do |modification_method|
      modified_text = self.send(modification_method, modified_text)
    end

    modified_text
  end

  private

  def modification_methods
    # TODO:
    #   - Use underscore in italics
    #   - Replace curly single open quote with straight single quote
    #   - Replace curly single end quote with straight single quote
    #   - Replace curly double open quote with straight double quote
    #   - Replace curly double end quote with straight double quote
    #   - Replace ellipsis with ...
    #   - Replace escaped ! with unescaped !
    #   - Replace escaped HR with unescaped HR
    #   - Replace escaped open square bracket with unescaped open square bracket
    #   - Replace escaped close square bracket with unescaaped close square
    #   bracket
    #   - Add ending newline if needed
    #   - Maybe: Convert en-dash to --
    #   - Maybe: Convert em-dash to ---
    %i[
      replace_underscore_text_with_underscore_character_for_italics
      replace_curly_single_quotes_with_straight
      replace_curly_double_quotes_with_straight
      replace_ellipsis_with_dotdotdot
      replace_escaped_exclamation_point_with_unescaped
      replace_escaped_open_square_brackets_with_unescaped
      replace_escaped_close_square_brackets_with_unescaped
      add_ending_newline_if_needed
    ]
  end

  def replace_underscore_text_with_underscore_character_for_italics(text)
    text.gsub(/ToUnDeRsCoRe/, '_')
  end

  def replace_curly_single_quotes_with_straight(text)
    text.gsub(/[‘’]/, "'")
  end

  def replace_curly_double_quotes_with_straight(text)
    text.gsub(/[“”]/, '"')
  end

  def replace_ellipsis_with_dotdotdot(text)
    text.gsub(/…/, '...')
  end

  def replace_escaped_exclamation_point_with_unescaped(text)
    text.gsub(/\\\!/, '!')
  end

  def replace_escaped_open_square_brackets_with_unescaped(text)
    text.gsub(/\\\[/, '[')
  end

  def replace_escaped_close_square_brackets_with_unescaped(text)
    text.gsub(/\\\]/, ']')
  end

  def add_ending_newline_if_needed(text)
    if text.end_with?("\n")
      text
    else
      "#{text}\n"
    end
  end
end

def perform_replacements_on_md_file(output_md_file)
  original_md_text = File.read(output_md_file)

  modified_md_text = MarkdownText.new(original_md_text).modified_text

  File.open(output_md_file, 'w') do |file|
    file.puts modified_md_text
  end
end

_original_command = <<HTML
pandoc --filter ./markdown_underscore_italics.rb  -s --wrap=none -t gfm -o ch2/index.with-pandoc.md ch2/ch2.with-pandoc.docx && sed -i '' -e 's/ToUnDeRsCoRe/_/g' -e s/\’/\'/g -e s/\“/\"/g -e s/\”/\"/g -e s/…/.../g -e 's/\\\!/\!/g' -e 's/\> \\---/---/' -e '$a\' ch2/index.with-pandoc.md
HTML

def execute_command_for(input_docx_filename, output_md_file)
  pandoc_cmd = build_pandoc_command(input_docx_filename, output_md_file)
  # sed_cmd = build_sed_command(output_md_file)

  # Intial way of doing things...
  # puts "Pandoc command:"
  # puts pandoc_cmd
  # `#{pandoc_cmd}`
  # puts "Sed command:"
  # puts sed_cmd
  # `#{sed_cmd}`

  # Second way of doing things...
  puts "Pandoc command:"
  puts pandoc_cmd
  `#{pandoc_cmd}`
  perform_replacements_on_md_file(output_md_file)
end

execute_command_for(input_docx_filename, output_md_file)
