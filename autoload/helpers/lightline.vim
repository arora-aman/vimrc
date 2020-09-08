function! helpers#lightline#fileName() abort
    let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
    if filename =~ 'NERD_tree'
        return ''
    endif
    let modified = &modified ? ' +' : ''
    return fnamemodify(filename, ":~:.") . modified
endfunction

function! helpers#lightline#gitBranch()
    return (exists("*FugitiveHead") ? ' ' . FugitiveHead() : '')
endfunction

function! helpers#lightline#currentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! helpers#lightline#gitBlame()
    return winwidth(0) > 100 ? strpart(substitute(get(b:, 'coc_git_blame', ''), '[\(\)]', '', 'g'), 0, 50) : ''
    " return winwidth(0) > 100 ? strpart(get(b:, 'coc_git_blame', ''), 0, 20) : ''
endfunction
