class PandocCommand
  attr_accessor :input_docx_filename, :output_md_file

  def initialize(input_docx_filename, output_md_file)
    self.input_docx_filename = input_docx_filename
    self.output_md_file = output_md_file
  end

  def execute
    puts "Pandoc command:"
    puts command_text
    `#{command_text}`
  end

private

  def command_text
    @command_text ||= <<CMD
pandoc #{filter_text} -s --wrap=none -t gfm -o "#{output_md_file}" "#{input_docx_filename}"
CMD
  end

  def filter_text
    return unless include_filter?

    "--filter #{underscore_filter_path}"
  end

  def include_filter?
    false
  end

  def underscore_filter_path
    dir = File.dirname(__FILE__)
    path = File.join(dir, 'markdown_underscore_italics.rb')
    "\"#{path}\""
  end
end

