(1..45).each do |chapter_number|
  toaes_v5_path = '/Users/kyletolle/Dropbox/everything/novels/thoughts-of-an-eaten-sun/v5'
  source_chapter_file = "toaes_pandoc_conversion_playground/ch#{chapter_number}.md"
  # destination_chapter_file = File.join(toaes_v5_path, "ch#{chapter_number}", 'index.edited.md')
  destination_chapter_file = File.join(toaes_v5_path, "ch#{chapter_number}", 'index.md')

  # puts "source", source_chapter_file
  # puts "destination_chapter_file", destination_chapter_file
  `cp #{source_chapter_file} #{destination_chapter_file}`
end
