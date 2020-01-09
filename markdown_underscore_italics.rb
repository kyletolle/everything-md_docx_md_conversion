#!/usr/bin/env ruby
# Use underscores for italics instead of asterisks
require "paru/filter"

Paru::Filter.run do
  with "Emph" do |emph|
    # Following an approach from https://stackoverflow.com/a/9898486/249218
    # STDERR.puts "Starting with this markdown: `#{emph.markdown}`"
    new_markdown = emph.markdown.gsub(/\*/, 'ToUnDeRsCoRe')
    # STDERR.puts "Converting to this markdown: `#{new_markdown}`"
    emph.markdown = new_markdown
  end
end
