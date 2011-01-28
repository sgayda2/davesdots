import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS

import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders(smartBorders)

import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)

import XMonad.Prompt
import XMonad.Prompt.Shell(shellPrompt)
import XMonad.Prompt.Window

import System.IO(hPutStrLn)

-- Things that should always float
myFloatHook = composeAll
	[ className =? "qemu" --> doFloat
	, title =? "xfce4-notifyd" --> doIgnore
	]


myLayoutHook = tiled ||| Grid ||| simpleTabbed
	where
		-- default tiling algorithm partitions the screen into two panes
		tiled   = Tall nmaster delta ratio

		-- The default number of windows in the master pane
		nmaster = 1

		-- Default proportion of screen occupied by master pane
		ratio   = 1/2

		-- Percent of screen to increment by when resizing panes
		delta   = 3/100

main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
			{ manageHook = manageDocks <+> myFloatHook <+> manageHook defaultConfig
			, modMask = mod4Mask
			, layoutHook = avoidStruts $ smartBorders $ myLayoutHook
			, logHook    = dynamicLogWithPP $ xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppUrgent = xmobarColor "#FF0000" "" . wrap "**" "**"
				, ppTitle  = xmobarColor "#8AE234" ""
				}
			}
			`additionalKeysP`
			[ ("M-p", shellPrompt defaultXPConfig { position = Top })
			, ("M-S-a", windowPromptGoto defaultXPConfig { position = Top })
			, ("M-a", windowPromptBring defaultXPConfig { position = Top })
			, ("M-S-l", spawn "~/bin/lock")
			, ("M-<Left>", moveTo Prev HiddenNonEmptyWS)
			, ("M-S-<Left>", shiftToPrev)
			, ("M-<Right>", moveTo Next HiddenNonEmptyWS)
			, ("M-S-<Right>", shiftToNext)
			, ("M-<Up>", windows W.focusUp)
			, ("M-S-<Up>", windows W.swapUp)
			, ("M-<Down>", windows W.focusDown)
			, ("M-S-<Down>", windows W.swapDown)
			, ("M-`", toggleWS)
			, ("M-s", moveTo Next EmptyWS)
			, ("M-S-s", shiftTo Next EmptyWS)
			]
