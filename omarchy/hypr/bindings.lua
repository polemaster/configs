-- Free up default bindings
hl.unbind("SUPER + SPACE")
hl.unbind("SUPER + SHIFT + SPACE")

-- Super + Space -> Direct Apps Launcher list
-- o.bind("SUPER + SPACE", "Apps", "omarchy-menu toggle apps")
o.bind("SUPER + SPACE", "Apps", "omarchy-shell omarchy.dock apps")

-- Super + Shift + Space -> Full Omarchy Menu
o.bind("SUPER + SHIFT + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Optional: Move "Toggle top bar" to Super + Alt + B so you don't lose it
o.bind_toggle("SUPER + ALT + B", "Toggle top bar", "bar")

-- Browser
o.bind("SUPER + B", "Browser", { omarchy = "browser" })

-- Change full tiling screen binding
hl.unbind("SUPER + SHIFT + F")
o.bind("SUPER + SHIFT + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Bind Super + E to open files instead of SUPER + SHIFT + F
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })

-- Lock screen
o.bind("SUPER + U", "Lock system", "omarchy-system-lock")

-- Moving through the windows with Super + h/j/k/l
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
o.bind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "left" }))
o.bind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "right" }))
o.bind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "up" }))
o.bind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "down" }))

-- Change windows in places (swapwindow -> hl.dsp.window.swap)
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER + SHIFT + K")
hl.unbind("SUPER + SHIFT + L")
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "left" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "right" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "up" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "down" }))

-- Bind help (previously Super + K) to Super + I
hl.unbind("SUPER + I")
o.bind("SUPER + I", "Show key bindings", "omarchy-menu-keybindings")

-- Bind toggle (previously Super + J) to Super + O
hl.unbind("SUPER + O")
o.bind("SUPER + O", "Toggle window split", hl.dsp.layout("togglesplit"))

-- Keybindings for fast moving through grouped windows
hl.unbind("SUPER + grave")
hl.unbind("SUPER + SHIFT + grave")
hl.unbind("ALT + grave")
hl.unbind("ALT + SHIFT + grave")
o.bind("SUPER + grave", "Next window in group", hl.dsp.group.next())
o.bind("SUPER + SHIFT + grave", "Previous window in group", hl.dsp.group.prev())
o.bind("ALT + grave", "Next window in group", hl.dsp.group.next())
o.bind("ALT + SHIFT + grave", "Previous window in group", hl.dsp.group.prev())

-- Shutdown button turns off the computer
hl.unbind("XF86PowerOff")
hl.bind("XF86PowerOff", hl.dsp.exec_cmd('sh -c "omarchy-state clear re*-required && systemctl poweroff --no-wall"'), {
  locked = true,
  description = "Shutdown",
})

-- Show date, weather & battery
hl.unbind("SUPER + CTRL + D")
hl.unbind("SUPER + CTRL + B")
o.bind("SUPER + CTRL + D", "Show time", 'notify-send -u low "    $(date +"%d %B %Y")"')
o.bind("SUPER + CTRL + B", "Show battery remaining", 'notify-send -u low "$(omarchy-battery-status)"')
