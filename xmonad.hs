import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS

import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.SimpleFloat
import XMonad.Layout.ResizableTile

import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)

import XMonad.Prompt
import XMonad.Prompt.Shell(shellPrompt)
import XMonad.Prompt.Window

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers

import System.IO(hPutStrLn)
import System.Posix.Unistd(getSystemID, nodeName)

-- Things that should always float
myFloatHook = composeAll [
	className =? "qemu" --> doFloat
	, className =? "Smplayer" --> doFloat
	, className =? "Wine" --> doFloat
	, className =? "VirtualBox" --> doFloat
	, className =? "Gimp" --> doFloat
	, title =? "xfce4-notifyd" --> doIgnore
	, isFullscreen --> doFullFloat
	]

myLayoutHook = tiled ||| Grid ||| simpleTabbed
	where
		-- default tiling algorithm partitions the screen into two panes
		tiled   = ResizableTall nmaster delta ratio []

		-- The default number of windows in the master pane
		nmaster = 1

		-- Default proportion of screen occupied by master pane
		ratio   = 1/2

		-- Percent of screen to increment by when resizing panes
		delta   = 3/100

getHostKey :: String -> KeyMask
getHostKey hostname =
	if hostname `elem` ["beaujolais", "urbania"] then mod4Mask
	else mod1Mask

main = do
	host <- fmap nodeName getSystemID -- TODO: make me mighty
	xmproc <- spawnPipe "xmobar"
	xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
			{ manageHook = manageDocks <+> myFloatHook <+> manageHook defaultConfig <+> scratchpadManageHook (W.RationalRect 0.25 0.25 0.5 0.5)
			, modMask = getHostKey host
			, layoutHook = avoidStruts $ smartBorders $ myLayoutHook
			, logHook    = dynamicLogWithPP $ xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppUrgent = xmobarColor "#FF0000" "" . wrap "**" "**"
				, ppTitle  = xmobarColor "#8AE234" ""
				}
			, terminal = "xterm"
			, handleEventHook = fullscreenEventHook
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
			, ("M-g", scratchpadSpawnAction defaultConfig { terminal = "xterm" })
			, ("<XF86Launch1>", spawn "chromium")
			, ("M-[", sendMessage MirrorExpand)
			, ("M-]", sendMessage MirrorShrink)
			]
