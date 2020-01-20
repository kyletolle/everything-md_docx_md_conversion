require_relative 'pandoc_command'
require_relative 'sed_command'

# Run this like:
# ```
# FirstWayOfDoingThings.new(input_docx_filename, output_md_file).run
# ```
#
class FirstWayOfDoingThings
  attr_accessor :input_docx_filename, :output_md_file

  def initialize(input_docx_filename, output_md_file)
    self.input_docx_filename = input_docx_filename
    self.output_md_file = output_md_file
  end

  def run
    PandocCommand.new(input_docx_filename, output_md_file).execute
    SedCommand.new(output_md_file).execute
  end
end

