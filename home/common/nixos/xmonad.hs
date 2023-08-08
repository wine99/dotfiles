import XMonad
import XMonad.Config.Desktop

baseConfig = desktopConfig

main = xmonad baseConfig
  { terminal    = "kitty"
  , modMask     = mod4Mask
  , borderWidth = 3 }
