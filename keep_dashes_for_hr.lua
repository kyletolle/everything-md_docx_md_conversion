-- Borrowed this from: https://github.com/jgm/pandoc/issues/2573
-- And there's a similar idea at https://gist.github.com/infotroph/5458cb5b4370092f9c32
local hashrule = [[<w:p>
  <w:pPr>
    <w:ind w:left="576" w:right="576"/>
    <w:jc w:val="center"/>
  </w:pPr>
  <w:r>
    <w:t>---</w:t>
  </w:r>
</w:p>]]

function HorizontalRule(el)
    return pandoc.RawBlock('openxml', hashrule)
end
