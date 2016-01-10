import System.IO
import Graphics.X11.ExtraTypes.XF86

import XMonad
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders
 
main = do
 xmproc <- spawnPipe "/home/jdo/.cabal/bin/xmobar /home/jdo/.xmobarrc"
 xmonad $ defaultConfig
	{ manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        },
	modMask = mod4Mask,
	focusFollowsMouse = False,
	borderWidth = 1,
	focusedBorderColor = "#108AB3"
	} `additionalKeys`
    [
      ((mod4Mask, xK_d), spawn "touch ~/.pomodoro_session"),
      ((mod4Mask .|. controlMask , xK_d), spawn "rm ~/.pomodoro_session"),
      ((0, 0x1008FF11), spawn "amixer set Master 2-"),
      ((0, 0x1008FF13), spawn "amixer set Master 2+")
    ]
