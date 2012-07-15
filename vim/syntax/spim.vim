" Vim syntax file

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Common Spim Assembly instructions
syn keyword spimInstruction add sub mul
syn keyword spimInstruction and or not
syn keyword spimInstruction sll srl sra
syn keyword spimInstruction beq bne ble blt bge bgt jal j jr
syn keyword spimInstruction la li lw move sub sw syscall

" Registers
syn match spimRegister			"$[a-zA-Z0-9]\+"

" Any other stuff
syn match spimIdentifier		"[a-z_][a-z0-9_]*"

" Instructions changing stack
syn match spimInstruction "\<inc\>"
syn match spimInstruction "\<dec\>"
syn match spimInstruction "\<ex\>"
syn match spimSpecInst "\<inc\s\+sp\>"me=s+3
syn match spimSpecInst "\<dec\s\+sp\>"me=s+3
syn match spimSpecInst "\<ex\s\+(\s*sp\s*)\s*,\s*hl\>"me=s+2

"Labels
syn match spimLabel		"[a-z_][a-z0-9_]*:"
syn match spimSpecialLabel	"[a-z_][a-z0-9_]*::"

" PreProcessor commands
syn match spimPreProc	"\.org"
syn match spimPreProc	"\.globl"
syn match spimPreProc	"\.db"
syn match spimPreProc	"\.dw"
syn match spimPreProc	"\.ds"
syn match spimPreProc	"\.data"
syn match spimPreProc	"\.text"
syn match spimPreProc	"\.byte"
syn match spimPreProc	"\.word"
syn match spimPreProc	"\.blkb"
syn match spimPreProc	"\.blkw"
syn match spimPreProc	"\.ascii"
syn match spimPreProc	"\.asciz"
syn match spimPreProc	"\.asciiz"
syn match spimPreProc	"\.module"
syn match spimPreProc	"\.title"
syn match spimPreProc	"\.sbttl"
syn match spimPreProc	"\.even"
syn match spimPreProc	"\.odd"
syn match spimPreProc	"\.area"
syn match spimPreProc	"\.page"
syn match spimPreProc	"\.setdp"
syn match spimPreProc	"\.radix"
syn match spimInclude	"\.include"
syn match spimPreCondit	"\.if"
syn match spimPreCondit	"\.else"
syn match spimPreCondit	"\.endif"

" Common strings
syn match spimString		"\".*\""
syn match spimString		"\'.*\'"

" Numbers
syn match spimNumber		"[0-9]\+"
syn match spimNumber		"0[xXhH][0-9a-fA-F]\+"
syn match spimNumber		"0[bB][0-1]*"
syn match spimNumber		"0[oO\@qQ][0-7]\+"
syn match spimNumber		"0[dD][0-9]\+"

" Character constant
syn match spimString		"\#\'."hs=s+1

" Comments
syn match spimComment		"#.*"

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_spim_syntax_inits")
  if version < 508
    let did_spim_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink spimSection		Special
  HiLink spimLabel		Label
  HiLink spimSpecialLabel	Label
  HiLink spimComment		Comment
  HiLink spimInstruction	Statement
  HiLink spimSpecInst		Statement
  HiLink spimInclude		Include
  HiLink spimPreCondit		PreCondit
  HiLink spimPreProc		PreProc
  HiLink spimNumber		Number
  HiLink spimString		String
  HiLink spimRegister		Identifier

  delcommand HiLink
endif

let b:current_syntax = "spim"
" vim: ts=8
