class SplitMdIntoChapters
  TITLE_HEADER_REGEX = /# Thoughts of an Eaten Sun\n\n/
  CHAPTER_HEADER_REGEX = /## \d+\n/
  CHAPTER_HEADER_CAPTURE_NUMBER_REGEX = /## (\d+)\n/
  CHAPTER_HEADER_LOOKAHEAD_REGEX = /(?=#{CHAPTER_HEADER_REGEX})/

  attr_accessor :all_chapters_text

  def initialize(all_chapters_text)
    self.all_chapters_text = all_chapters_text
  end

  def chapters
    # Uses a positive lookahead assertion in regex. Used
    # https://stackoverflow.com/a/18089658/249218 and
    # https://www.regular-expressions.info/lookaround.html for help.
    headers_and_chapters = all_chapters_text.split(CHAPTER_HEADER_LOOKAHEAD_REGEX)
    # p headers_and_chapters
    _just_chapters = headers_and_chapters
      .reject do |text|
        _is_book_title_header = text.match?(TITLE_HEADER_REGEX)
      end
  end

  def write_chapter_files
    chapters.each do |chapter|
      chapter_number = chapter.match(CHAPTER_HEADER_CAPTURE_NUMBER_REGEX)[1]
      chapter_file_path = "ch#{chapter_number}.md"
      File.open(chapter_file_path, 'w') do |chapter_file|
        puts "Writing file to #{chapter_file_path}..."
        chapter_file.puts chapter
      end
    end
  end
end

