local pluginDir = noctalia.pluginDir()
local toggle = false

function update()
    noctalia.setUpdateInterval(3600000)
    barWidget.setGlyph("cpu")
    barWidget.setTooltip("Log work")
end

function onClick()
    noctalia.runAsync("python " .. pluginDir .. "/log.py " .. "work", function(_)
        toggle = not toggle
        noctalia.state.set("timelog_work", toggle)
    end)
end
