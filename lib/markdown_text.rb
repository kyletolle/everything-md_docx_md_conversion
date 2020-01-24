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
    #   - Replace em-dash with ---
    #   - Replace en-dash with --
    #   - Add ending newline if needed
    %i[
      replace_underscore_text_with_underscore_character_for_italics
      replace_curly_single_quotes_with_straight
      replace_curly_double_quotes_with_straight
      replace_ellipsis_with_dotdotdot
      replace_escaped_exclamation_point_with_unescaped
      replace_escaped_open_square_brackets_with_unescaped
      replace_escaped_close_square_brackets_with_unescaped
      replace_em_dash_with_dashdashdash
      replace_en_dash_with_dashdash
      replace_esacped_pound_sign_with_hr
      replace_expanded_dotdotdot_with_condensed
      replace_nonbreaking_space_with_regular_space
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

  def replace_em_dash_with_dashdashdash(text)
    text.gsub(/—/, '---')
  end

  def replace_en_dash_with_dashdash(text)
    text.gsub(/–/, '---')
  end

  def replace_esacped_pound_sign_with_hr(text)
    # In the ToaES doc for copyediting, I used # for section break. I want to
    # convert those back to --- for markdown section breaks.
    text.gsub(/\\#/, '---')
  end

  # TODO: Actually, when generating an expanded dotdotdot, we should use
  # non-breaking spaces between the dots, as mentioned in
  # https://www.liminalpages.com/ellipsis-spaces-dots.
  def replace_expanded_dotdotdot_with_condensed(text)
    # In ToaES doc for copyediting, three dots separeted by spaces were used
    # instead of ellipsis. I want to convert those back to regular dotdotdots.
    text.gsub(/ \. \. \./, '...')
  end

  def replace_nonbreaking_space_with_regular_space(text)
    # TODO: Not sure if I should keep the non-breaking spaces that are currently
    # used in ToaES.
    # Note: You can type a non-breaking space in Word with Option+Shift+Space
    # (Mac) or Ctrl+Shift+Space (Windows).
    # text.gsub(/ /, ' ')
  end

  def add_ending_newline_if_needed(text)
    if text.end_with?("\n")
      text
    else
      "#{text}\n"
    end
  end
end
