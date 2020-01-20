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
pandoc --filter ./markdown_underscore_italics.rb -s --wrap=none -t gfm -o #{output_md_file} #{input_docx_filename}
CMD
  end
end

