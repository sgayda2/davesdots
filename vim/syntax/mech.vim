" Vim syntax file

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" Tiles
syn match mapGrass	"g"
syn match mapDesert	"d"
syn match mapPlains	"p"
syn match mapJungle	"j"
syn match mapSwamp	"s"
syn match mapIce	"i"
syn match mapRoad	"r"
syn match mapWater	"w"
syn match mapHotRock	"h"
syn match mapForest	"f"
syn match mapMountain	"m"
syn match mapComment    "%.*"

" Special
syn match mapDim	"^[0-9]*$"
syn match mapHero	"[1-4]"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_map_syntax_inits")
	if version < 508
		let did_map_syntax_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink mapDim		Special
	HiLink mapHero		Number
	HiLink mapGrass		String
	HiLink mapMountain	Comment
	HiLink mapForest	String
	HiLink mapHotRock	PreCondit
	HiLink mapWater		Statement
	HiLink mapRoad		Comment
	HiLink mapSwamp		Statement
	HiLink mapJungle	Include
	HiLink mapPlains	Identifier
	HiLink mapDesert	PreProc
	HiLink mapIce		Special
	delcommand HiLink
endif
let b:current_syntax = "mech"
" vim: set ts=8 sw=8 :
