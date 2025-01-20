;; extend

(block
  (identifier)
  (string_lit
    (quoted_template_start)
    (template_literal)
    (quoted_template_end))
  (string_lit
    (quoted_template_start)
    (template_literal)
    (quoted_template_end)
    ) @string (#set! priority 155)
  )
