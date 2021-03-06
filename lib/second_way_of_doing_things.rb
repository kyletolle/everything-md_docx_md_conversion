require_relative 'pandoc_command'
require_relative 'markdown_text'
require_relative 'split_md_into_chapters'

# Run this like:
# ```
# SecondWayOfDoingThings.new(input_docx_filename, output_md_file).run
# ```
#
class SecondWayOfDoingThings
  attr_accessor :input_docx_filename, :output_md_file

  def initialize(input_docx_filename, output_md_file)
    self.input_docx_filename = input_docx_filename
    self.output_md_file = output_md_file
  end

  def run
    PandocCommand.new(input_docx_filename, output_md_file).execute

    puts "Modifying text..."
    perform_replacements_on_md_file

    puts "Splitting into a file per chapter"
    split_into_chapter_files
  end

private

  def perform_replacements_on_md_file
    original_md_text = read_md_file

    modified_md_text = MarkdownText.new(original_md_text).modified_text

    File.open(output_md_file, 'w') do |file|
      file.puts modified_md_text
    end
  end

  def read_md_file
    File.read(output_md_file)
  end

  def split_into_chapter_files
    all_chapters_text = read_md_file

    SplitMdIntoChapters.new(all_chapters_text).write_chapter_files
  end
end
