------------------
--display setups--
------------------

--main monitor--
hl.monitor({
    output = "DP-2",
    mode = "2560x1440@144.001",
    position = "0x0",
    scale = 1
})

--secondary monitor to the left & horizontal--
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@74.973",
    position = "-1080x0", --finetune later!!
    scale = 1,
    transform = 3
})

hl.window_rule({
        match = {
            float = false
        },
        rounding = 6,
        border_size = 1
})

hl.window_rule({
    match = {
        focus = false
    },
    opacity = 0.75
})


----------------
--startup apps--
----------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("swaybg -o DP-2 -i ~/Pictures/Wallpapers/wallhaven-o5wok7_2560x1440.png -m fill -o HDMI-A-1 -i ~/Pictures/Wallpapers/wallhaven-v9qdg3_1920x1080.png -m fill")
end)


-------------
--functions--
-------------

--function to drag a window like in a DE--
local function drag_n_drop()
    local cursor = hl.get_cursor_pos()
    local win = hl.get_active_window()
    local margin = 5

    if not cursor or not win then return false end

    local top = win.at.y
    local on_top = cursor.y >= (top - margin) and cursor.y <= (top + margin)

    if on_top then
        hl.dispatch(hl.dsp.window.float({ float = true, {window}}))
        --hl.dispatch(hl.dsp.window.resizetotal({{x = 600, y = 400}, {window}}))
        --need to add line to make window smaller once it is floating
        hl.dispatch(hl.dsp.window.drag({window}))
    end
end





------------
--bindings--
------------

--draging--
hl.config({
    binds = {
        drag_threshold = 10
    }
})

--temp--
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exit{})

----------------
--app bindings--
----------------

--best terminal--
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))

--rofi app launcher--
hl.bind("SUPER + A", hl.dsp.exec_cmd("rofi -show drun"))

--use swaybg on startup done below--
--add script to refresh here with a keybind--

-------------------
--window bindings--
-------------------

--close window--
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close({window}))

--force kill window--
hl.bind("SUPER + SHIFT + escape", hl.dsp.window.kill({window}))

--fullscreen toggle--
hl.bind("SUPER + F", hl.dsp.window.fullscreen({maximized, toggle, window}))

--minimise window--
hl.bind("SUPER + mouse:273", hl.dsp.window.move({workspace = "special", follow = False}))

--make window floating and drag--
hl.bind("mouse:272", drag_n_drop)


----------------
--future ideas--
----------------

--music player notification overlay when audio playing in a floating window on secondary monitor







