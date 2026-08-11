local pluginDir = noctalia.pluginDir()
local toggle = false

function update()
    noctalia.setUpdateInterval(3600000)
    barWidget.setGlyph("coffee")
    barWidget.setTooltip("Clock in / Break")
end

function onClick()
    noctalia.runAsync("python " .. pluginDir .. "/log.py " .. "in", function(_)
        toggle = not toggle
        noctalia.state.set("timelog_in", toggle)
    end)
end
