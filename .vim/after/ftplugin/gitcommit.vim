setlocal textwidth=72
let b:undo_ftplugin .= "|setl tw<"

if exists('+colorcolumn')
    set colorcolumn=72
endif
