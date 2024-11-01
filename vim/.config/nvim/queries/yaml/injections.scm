; extend

; Support Idea-style injection: # language=yaml
; Inject language toplevel yaml node
(
  (comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
  (block_mapping_pair
    value: (block_node
      (block_scalar) @injection.content
      (#offset! @injection.content 0 1 0 0)
    )
  )
)

; Support Idea-style injection: # language=yaml
; Inject language in yaml body
(block_mapping_pair
  (comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
  value: (block_node
    (block_mapping
    (block_mapping_pair
      value: (block_node
        (block_scalar) @injection.content
        (#offset! @injection.content 0 1 0 0)
        )
      )
    )
  )
)

