; information useful for sorting - see
; lua/nikdewally/ledger_tools.lua

(("\n") @node
(#has-parent? @node "source_file")
(#set! kind "top_level_whitespace")
)

(journal_item
    (_) @_node
    (#not-kind-eq? @_node "xact")
    (#set! kind "not_xact")
) @node

(journal_item
    (xact (plain_xact (date) @date))
    (#set! kind "plain_xact")
) @node

(journal_item
    (xact (automated_xact))
    (#set! kind "automated_xact")
) @node

(journal_item
    (xact (periodic_xact))
    (#set! kind "periodic_xact")
) @node



