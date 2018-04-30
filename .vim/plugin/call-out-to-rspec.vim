function! RunCurrentSpecFile()
  if InSpecFile()
    let l:command = g:rspec_command . " " . @% . " " . g:rspec_additional_command
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunNearestSpec()
  if InSpecFile()
    let l:command = g:rspec_command . " " . @% . ":" . line(".") . " " . g:rspec_additional_command
    echo l:command
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunLastSpec()
  if exists("t:last_spec_command")
    call RunSpecs(t:last_spec_command)
  endif
endfunction

function! RunRake()
  let l:command = "bundle exec rake"
  call SetLastSpecCommand(l:command)
  call RunSpecs(l:command)
endfunction

function! InSpecFile()
  return (match(expand("%"), "_spec.rb$") != -1) || (match(expand("%"), "_test.rb$") != -1)
endfunction

function! SetLastSpecCommand(command)
  let t:last_spec_command = a:command
endfunction

function! RunSpecs(command)
  execute ":w\|:Dispatch " . a:command
endfunction
