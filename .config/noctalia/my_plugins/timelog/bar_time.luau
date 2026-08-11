local pluginDir = noctalia.pluginDir()

local function refresh()
    noctalia.runAsync("python " .. pluginDir .. "/calc.py", function(output)
        local outputText = output.stdout
        local lines = {}
        if outputText then
            for line in outputText:gmatch("[^\n]+") do
                table.insert(lines, line)
            end
        end

        if #lines < 2 then
            barWidget.setText("[¬º-°]¬  0h 00m")
            barWidget.setTooltip("No entries today.")
            return
        end

        local hasEntryToday = lines[1] == "true"
        local emoji = hasEntryToday and "ヽ(｀Д´)ﾉ ┻━┻  " or "[¬º-°]¬  "
        barWidget.setText(emoji .. lines[2])

        local summary = {}
        for i = 3, #lines do
            table.insert(summary, lines[i])
        end
        barWidget.setTooltip(#summary > 0 and table.concat(summary, "\n") or "No entries today.")
    end)
end

noctalia.state.watch("timelog_in",   function(_) refresh() end)
noctalia.state.watch("timelog_work", function(_) refresh() end)

function update()
    noctalia.setUpdateInterval(60000)
    refresh()
end

function onClick()
    local logFile = noctalia.expandPath("~/.local/share/gtimelog/timelog.txt")
    noctalia.runInTerminal(noctalia.getenv("EDITOR") .. " " .. logFile .. " +$")
end
