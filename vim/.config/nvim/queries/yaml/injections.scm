; extend

; Support Idea-style injection: # language=yaml
((comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
  .
  (block_mapping_pair
    value: (block_node
      (block_scalar) @injection.content
      ; Start parse only after block indicator
      (#offset! @injection.content 0 1 0 0))))

; Inject language at toplevel yaml node
((comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
  .
  (block_mapping_pair
    value: (flow_node
      (plain_scalar(string_scalar) @injection.content
      ))))

; Inject language at toplevel yaml node
; Inject language in flow node in quoted string
((comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
  .
  (block_mapping_pair
    value: (flow_node
      (_) @injection.content
      ))
  ; Don't parse last quote as bash sentence
  (#offset! @injection.content 0 1 0 -1)
)

; Inject language in yaml body
(block_mapping_pair
  (comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
  value: (block_node
    (block_mapping
      .
      [(block_mapping_pair
        value: (block_node
          (block_scalar) @injection.content
          (#offset! @injection.content 0 1 0 0)))]
      )))
