# everything-md_docx_md_conversion

For converting markdown to docx and then back to markdown, without losing or changing the original formatting.

## About

I wrote all of the _Thoughts of an Eaten Sun_ novel in Markdown. In order to get it critiqued and edited, I had need to covert the file into docx. I used Pandoc for this, which worked well. But there's a downside that I was not able to easily convert the docx back into markdown without a lot of changes. What were these things:

- Markdown horizontal rules are lost semantically when converting to docx
- Even after hacking things to preserve the HR, the dashes are escaped when converting back to MD
- Smart quotes are not converted back into dumb quotes
- En- and em-dashes are not converted back to their markdown equivalent
- Pandoc writes markdown italics as `*` instead of the `_` I prefer
- Exclamation points are escaped
- Square brackets are escaped
- The file doesn't have an ending blank line

This project is intended to make it possible for me to take a series of chapters written in markdown, convert them to docx, and then convert that resulting docx file back into markdown without all my original formatting being lost.

## Installation

- Install pandoc using homebrew

```
brew install pandoc
```

- Install paru gem

```
gem install paru
```

- Make sure that `convert_from_docx_to_md.rb` is executable

```
chmod +x convert_from_docx_to_md.rb
```

## Usage

```
./convert_from_docx_to_md.rb "ch2/ch2.with-pandoc.docx" "ch2/index.with-pandoc.md"
```

Or with files in other directories:
```
./convert_from_docx_to_md.rb ~/Dropbox/everything/novels/bones-of-a-broken-world/draft-1/ch2/ch2.with-pandoc.docx ~/Dropbox/everything/novels/bones-of-a-broken-world/draft-1/ch2/index.with-pandoc.md
```


## Original Commands

Originally, I played around on the command line until I got these commands, which do most of what I wanted. It's quite cryptic to understand what's going on, so I created this project in order to create a Ruby script to do what I wanted and break it out so that the code is more understandable.

These commands aren't exhaustive in what I want them to do either, but they're where I started from, so I wanted to note them.

### Command to Convert from MD to DOCX

With filenames hardcoded:
```
pandoc -s --lua-filter ./keep_dashes_for_hr.lua --reference-doc=ch2/boabw-pandoc-custom-reference.docx -o ch2/ch2.with-pandoc.docx ch2/index.md
```

Then, modified a bit to use env vars for filenames:
```
MD_SOURCE='ch2/index.md';
DOCX_OUTPUT='ch2/ch2.with-pandoc.docx';
pandoc -s --lua-filter ./keep_dashes_for_hr.lua --reference-doc=ch2/boabw-pandoc-custom-reference.docx -o $DOCX_OUTPUT $MD_SOURCE;
```

### Command to Convert from DOCX to MD

With filenames hardcoded:
```
pandoc --filter ./markdown_underscore_italics.rb  -s --wrap=none -t gfm -o ch1/index.with-pandoc.md ch1/ch1.with-pandoc.docx && sed -i '' -e 's/ToUnDeRsCoRe/_/g' -e s/\‘/\'/g -e s/\’/\'/g -e s/\“/\"/g -e s/\”/\"/g -e s/…/.../g -e 's/\\\!/\!/g' -e 's/\> \\---/---/' -e 's/\\\[/\[/g' -e 's/\\\]/\]/g' -e '$a\' ch1/index.with-pandoc.md
```

Then, modified a bit to use env vars for filenames:
```
DOCX_OUTPUT='ch2/ch2.with-pandoc.docx';
MD_OUTPUT='ch2/index.with-pandoc.md';
pandoc --filter ./markdown_underscore_italics.rb  -s --wrap=none -t gfm -o $MD_OUTPUT $DOCX_OUTPUT && sed -i '' -e 's/ToUnDeRsCoRe/_/g' -e s/\‘/\'/g -e s/\’/\'/g -e s/\“/\"/g -e s/\”/\"/g -e s/…/.../g -e 's/\\\!/\!/g' -e 's/\> \\---/---/' -e 's/\\\[/\[/g' -e 's/\\\]/\]/g' -e '$a\' $MD_OUTPUT;
```

## License

MIT
