local hotkey = require "mjolnir.hotkey"
local screen = require "mjolnir.screen"
local window = require "mjolnir.window"
local grid = require "mjolnir.bg.grid"
-- local hints = require "mjolnir.th.hints"

--
-- Grid Configuration
--
-- grid size
grid.HEIGHT = 100
grid.WIDTH = 100
-- padding for reserved space
grid.PADTOP = 0
grid.PADBOTTOM = 2
grid.PADLEFT = 19
grid.PADRIGHT = 1

-- mjolnir.bg.grid setup
grid.GRIDWIDTH = grid.HEIGHT
grid.GRIDHEIGHT = grid.WIDTH
grid.MARGINX = 0
grid.MARGINY = 0
-- calculated variables for later use
grid.PADHEIGHT = (grid.PADTOP + grid.PADBOTTOM)
grid.PADWIDTH = (grid.PADLEFT + grid.PADRIGHT)
grid._HEIGHT = (grid.HEIGHT - grid.PADHEIGHT) -- usable height
grid._WIDTH = (grid.WIDTH - grid.PADWIDTH) -- usable width

-- move window to a grid reference
function moveWindow(win, gridRef, relative)
    local scr = screen.mainscreen()
    if relative then
        curGridRef = grid.get(win, scr)
        for key, val in pairs(curGridRef) do
            gridRef[key] = (val + (gridRef[key] or 0))
        end
    end
    grid.set(win, gridRef, scr)
end
-- move the currnetly focused window
function moveCurrentWindow(gridRef, relative)
    moveWindow(window.focusedwindow(), gridRef, relative)
end

--
-- Global Hotkeys
--
local mash = {"cmd", "alt", "ctrl"}
-- app switching
-- hotkey.bind(mash, "/", hints.windowHints)
-- floating centre
hotkey.bind(mash, "c", function()
    local padX = 6.5
    local padY = 5
    moveCurrentWindow({
        x = (grid.PADLEFT + padX),
        y = (grid.PADTOP + padY),
        w = (grid._WIDTH - (padX * 2)),
        h = (grid._HEIGHT - (padY * 1.5))
    })
end)
-- maximize
hotkey.bind(mash, "m", function()
    moveCurrentWindow({
        x = grid.PADLEFT,
        y = grid.PADTOP,
        w = grid._WIDTH,
        h = grid._HEIGHT,
    })
end)

--
-- Sides
--
-- top side
hotkey.bind(mash, "up", function()
    moveCurrentWindow({
        x = grid.PADLEFT,
        y = grid.PADTOP,
        w = grid._WIDTH,
        h = (grid._HEIGHT / 2),
    })
end)
-- bottom side
hotkey.bind(mash, "down", function()
    moveCurrentWindow({
        x = grid.PADLEFT,
        y = (grid.PADTOP + (grid._HEIGHT / 2)),
        w = grid._WIDTH,
        h = (grid._HEIGHT / 2),
    })
end)
-- right side
hotkey.bind(mash, "right", function()
    moveCurrentWindow({
        x = (grid.PADLEFT + (grid._WIDTH / 2)),
        y = grid.PADTOP,
        w = (grid._WIDTH / 2),
        h = grid._HEIGHT,
    })
end)
-- left side
hotkey.bind(mash, "left", function()
    moveCurrentWindow({
        x = grid.PADLEFT,
        y = grid.PADTOP,
        w = (grid._WIDTH / 2),
        h = grid._HEIGHT
    })
end)

--
-- Corners
--
mash = {"alt", "ctrl", "shift"}
-- top right corner
hotkey.bind(mash, "up", function()
    moveCurrentWindow({
        x = (19 + 40),
        y = 0,
        w = 40,
        h = 49
    })
end)
-- bottom left corner
hotkey.bind(mash, "down", function()
    moveCurrentWindow({
        x = 19,
        y = 49,
        w = 40,
        h = 49
    })
end)
-- bottom right corner
hotkey.bind(mash, "right", function()
    moveCurrentWindow({
        x = (19 + 40),
        y = 49,
        w = 40,
        h = 49
    })
end)
-- top left corner
hotkey.bind(mash, "left", function()
    moveCurrentWindow({
        x = 19,
        y = 0,
        w = 40,
        h = 49
    })
end)

--
-- Grow/Shrink
--
mash = {"cmd", "ctrl", "shift"}
-- grow height
hotkey.bind(mash, "up", function()
    moveCurrentWindow({y = -1, h = 2}, true)
end)
-- shrink height
hotkey.bind(mash, "down", function()
    moveCurrentWindow({y = 1, h = -2}, true)
end)
-- grow width
hotkey.bind(mash, "right", function()
    moveCurrentWindow({x = -1, w = 2}, true)
end)
-- shrink width
hotkey.bind(mash, "left", function()
    moveCurrentWindow({x = 1, w = -2}, true)
end)

--
-- Nudge
--
mash = {"cmd", "alt", "shift"}
-- nudge up
hotkey.bind(mash, "up", function()
    moveCurrentWindow({y = -1}, true)
end)
-- nudge down
hotkey.bind(mash, "down", function()
    moveCurrentWindow({y = 1}, true)
end)
-- nudge right
hotkey.bind(mash, "right", function()
    moveCurrentWindow({x = 1}, true)
end)
-- nudge left
hotkey.bind(mash, "left", function()
    moveCurrentWindow({x = -1}, true)
end)
