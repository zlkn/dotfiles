;extend

((comment) @injection.language
  (#gsub! @injection.language "#%s*language=%s*([%w%p]+)%s*" "%1")
 .
(redirected_statement
redirect: (heredoc_redirect
  (heredoc_start)
  (heredoc_body) @injection.content
  (heredoc_end))))

