; extend

((comment) @injection.content
  (#set! injection.language "comment"))

; Inject language from top level yaml
((comment) @_lang
  ; (#any-of? @_lang "sql" "yaml")
  (block_mapping_pair
    key: (flow_node)
    value: (block_node
      (block_scalar) @injection.content
      (#set! injection.language "yaml")
      (#offset! @injection.content 0 1 0 0)
    )
))

; Inject language in yaml body
(block_mapping_pair
  (comment) @_lang
    value: (block_node
      (block_mapping
        (block_mapping_pair
          key: (flow_node)
          value: (block_node
            (block_scalar) @injection.content
            (#set! injection.language "yaml")
            (#offset! @injection.content 0 1 0 0)
          )
        )
      )
  )
)

