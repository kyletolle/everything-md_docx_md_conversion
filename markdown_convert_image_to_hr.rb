#!/usr/bin/env ruby
# Convert an image to a horizontal rule
require "paru/filter"

Paru::Filter.run do
  with "Node" do |n|
    STDERR.puts "Processing a node of type #{n.type} with contents:"
    STDERR.puts n.markdown
    n
  end

  with "Image" do |image|
    # Following an approach from https://stackoverflow.com/a/9898486/249218
    STDERR.puts "Processing an image"
    # image.inner_markdown = '---'
    # new_markdown = emph.markdown.gsub(/\*/, 'ToUnDeRsCoRe')
    # emph.markdown = new_markdown
  end

  with "HorizontalRule" do |hr|
    STDERR.puts "Processing a HR"
  end

  with "RawBlock" do |rb|
    STDERR.puts "Processing a RawBlock"
  end

  with "RawInline" do |ri|
    STDERR.puts "Processing a RawInline"
  end
end
