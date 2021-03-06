class SedCommand
  attr_accessor :output_md_file

  def initialize(output_md_file)
    self.output_md_file = output_md_file
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

  def execute
    puts "Sed command:"
    puts command_text
    `#{command_text}`
  end

private

  def command_text
    @command_text ||= <<CMD
sed -i '' -e #{SED_USE_UNDERSCORE_FOR_ITALICS} -e #{SED_REPLACE_CURLY_SINGLE_OPEN_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE} -e #{SED_REPLACE_CURLY_SINGLE_END_QUOTE_WITH_STRAIGHT_SINGLE_QUOTE} -e #{SED_REPLACE_CURLY_DOUBLE_OPEN_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE} -e #{SED_REPLACE_CURLY_DOUBLE_END_QUOTE_WITH_STRAIGHT_DOUBLE_QUOTE} -e #{SED_REPLACE_ELLIPSIS_WITH_DOTDOTDOT} -e #{SED_REPLACE_ESCAPED_EXCLAMATION_POINT_WITH_REGULAR_EXCLAMATION_POINT} -e #{SED_REPLACE_ESCAPED_HR_WITH_UNESCAPED_HR} -e #{SED_ADD_AN_ENDING_NEWLINE_IF_NEEDED} -e #{SED_REPLACE_ESCAPED_OPEN_BRACKETS_WITH_UNESCAPED_OPEN_BRACKETS} -e #{SED_REPLACE_ESCAPED_CLOSE_BRACKETS_WITH_UNESCAPED_CLOSE_BRACKETS} #{output_md_file}
CMD
  end
end
