import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets

Item {
    id: root

    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    implicitWidth: layout.implicitWidth
    implicitHeight: Style.barHeight

    property string workedHours: "0h 00m"
    property bool hasEntryToday: false
    property string daySummary: "No entries today."
    property string lastStatus: ""

    property string pyCalcScript: `import sys, os
from datetime import datetime, timedelta

log_file = os.path.expanduser("~/.local/share/gtimelog/timelog.txt")
if not os.path.exists(log_file):
    print("false")
    print("0h 00m")
    sys.exit(0)

now = datetime.now()
today = now.strftime("%Y-%m-%d")
start_of_week = (now - timedelta(days=now.weekday())).replace(hour=0, minute=0, second=0, microsecond=0)

today_total_seconds = 0
week_total_seconds = 0
last_time_today = None
last_time_week = None
has_today = False
today_lines = []

with open(log_file, "r") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue

        parts = line.split(": ", 1)
        if len(parts) != 2:
            continue

        try:
            current_time = datetime.strptime(parts[0], "%Y-%m-%d %H:%M")
        except ValueError:
            continue

        # Weekly Calculation
        if current_time >= start_of_week:
            if last_time_week is not None and last_time_week.date() == current_time.date():
                if not (parts[1].endswith("**") or parts[1].endswith("***")):
                    week_total_seconds += (current_time - last_time_week).total_seconds()
            last_time_week = current_time

        # Daily Calculation
        if line.startswith(today):
            has_today = True
            today_lines.append(line[11:])

            if last_time_today is not None:
                if not (parts[1].endswith("**") or parts[1].endswith("***")):
                    today_total_seconds += (current_time - last_time_today).total_seconds()

            last_time_today = current_time

elapsed_since_last_time = (datetime.now() - last_time_today).total_seconds() if last_time_today else 0

hours = int(today_total_seconds // 3600)
minutes = int((today_total_seconds % 3600) // 60)
elapsed_hours = int(elapsed_since_last_time // 3600)
elapsed_minutes = int((elapsed_since_last_time % 3600) // 60)

time_str = "{}h {:02d}m + {}h {:02d}m".format(hours, minutes, elapsed_hours, elapsed_minutes)

# Calculate elapsed time for the week if currently working
week_elapsed = elapsed_since_last_time
total_week_seconds = week_total_seconds + week_elapsed
week_hours = int(total_week_seconds // 3600)
week_minutes = int((total_week_seconds % 3600) // 60)
week_str = "{}h {:02d}m".format(week_hours, week_minutes)

print("true" if has_today else "false")
print(time_str)

if has_today:
    for tl in today_lines:
        print(tl)
    print("")
    print("Total today: " + time_str)
print("Total week:  " + week_str)
`

    Process {
        id: timeProcess
        command: ["python3", "-c", root.pyCalcScript]
        running: true
        stdout: StdioCollector {
            id: stdoutCol
            onStreamFinished: {
                let text = stdoutCol.text.trim();
                if (text !== "") {
                    let lines = text.replace(/\r/g, "").split("\n");

                    if (lines.length >= 2) {
                        root.hasEntryToday = (lines[0].trim() === "true");
                        root.workedHours = lines[1].trim();

                        if (lines.length > 2) {
                            root.daySummary = lines.slice(2).join("\n");
                        } else {
                            root.daySummary = "No entries today.";
                        }
                    }
                }
            }
        }
    }

    Process {
        id: cmdProcess
        command: []
        running: false
        onRunningChanged: {
            if (!running && command.length > 0) {
                timeProcess.running = false;
                timeProcess.running = true;
            }
        }
    }

    Process {
        id: openFileProcess
        command: [Quickshell.env("TERMINAL"), "-e", Quickshell.env("EDITOR"), Quickshell.env("HOME") + "/.local/share/gtimelog/timelog.txt", "+$"]
        running: false
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
            timeProcess.running = false;
            timeProcess.running = true;
        }
    }

    function executeLog(action) {
        if (cmdProcess.running) return;

        let pyWriteScript = `import sys, os, subprocess, tempfile
from datetime import datetime

action = "${action}"
log_file = os.path.expanduser("~/.local/share/gtimelog/timelog.txt")
log_dir = os.path.dirname(log_file)
nl = chr(10)

os.makedirs(log_dir, exist_ok=True)

now = datetime.now()
today_str = now.strftime("%Y-%m-%d")
ts_str = now.strftime("%Y-%m-%d %H:%M:")

lines = []
if os.path.exists(log_file):
    with open(log_file, 'r') as f:
        lines = f.readlines()

has_today = any(line.strip().startswith(today_str) for line in lines)

if action == "in":
    if not has_today:
        if lines and lines[-1].strip() != "":
            if not lines[-1].endswith(nl):
                lines[-1] += nl
            lines.append(nl)
        entry = "arrived ***"
    else:
        entry = "away **"

    lines.append(ts_str + " " + entry + nl)

elif action == "work":
    if lines and lines[-1].strip().startswith(today_str) and lines[-1].strip().endswith(": work"):
        lines[-1] = ts_str + " work" + nl
    else:
        lines.append(ts_str + " work" + nl)

with tempfile.NamedTemporaryFile("w", dir=log_dir, delete=False) as tf:
    tf.writelines(lines)
    tf.flush()
    os.fsync(tf.fileno())
    temp_name = tf.name

os.replace(temp_name, log_file)

today_lines = []
total_seconds = 0
last_time = None

for line in lines:
    line = line.strip()
    if not line or not line.startswith(today_str):
        continue

    today_lines.append(line[11:])

    parts = line.split(": ", 1)
    if len(parts) != 2:
        continue

    try:
        current_time = datetime.strptime(parts[0], "%Y-%m-%d %H:%M")
    except ValueError:
        continue

    if last_time is not None:
        if not (parts[1].endswith("**") or parts[1].endswith("***")):
            total_seconds += (current_time - last_time).total_seconds()

    last_time = current_time

hours = int(total_seconds // 3600)
minutes = int((total_seconds % 3600) // 60)
total_time_str = "{}h {:02d}m".format(hours, minutes)

notify_body = "<br>".join(today_lines) + "<br><br><b>Total today: " + total_time_str + "</b>"
subprocess.run(["notify-send", "-a", "GTimeLog", "GTimeLog", notify_body])
`;

        cmdProcess.command = ["python3", "-c", pyWriteScript];
        cmdProcess.running = true;
    }

    Rectangle {
        anchors.fill: parent
        color: Style.capsuleColor
        radius: Style.radiusM

        HoverHandler {
            id: widgetHover
        }

        PopupWindow {
            id: summaryPopup
            visible: widgetHover.hovered
            color: "transparent"

            anchor {
                window: root.QsWindow.window
                onAnchoring: {
                    let pos = root.QsWindow.contentItem.mapFromItem(
                        root,
                        (root.width / 2) - (summaryPopup.width / 2),
                        root.height + Style.marginM
                    );
                    anchor.rect.x = pos.x;
                    anchor.rect.y = pos.y;
                }
            }

            implicitWidth: popupContent.implicitWidth
            implicitHeight: popupContent.implicitHeight

            Rectangle {
                id: popupContent
                color: Color.mSurface
                radius: Style.radiusL
                border.color: Color.mSurfaceVariant
                border.width: 1

                implicitWidth: summaryText.implicitWidth + (Style.marginL * 2)
                implicitHeight: summaryText.implicitHeight + (Style.marginM * 2)

                NText {
                    id: summaryText
                    anchors.centerIn: parent
                    text: root.daySummary
                    color: Color.mOnSurface
                    pointSize: Style.fontSizeS
                    horizontalAlignment: Text.AlignLeft

                    maximumLineCount: 100
                    wrapMode: Text.NoWrap
                    lineHeight: 1.2
                }
            }
        }

        RowLayout {
            id: layout
            anchors.fill: parent
            anchors.leftMargin: Style.marginL
            anchors.rightMargin: Style.marginL
            spacing: Style.marginL

            NText {
                property bool needClockIn: !root.hasEntryToday

                text: {
                    let emoji = needClockIn ?  "[¬º-°]¬  " : "ヽ(｀Д´)ﾉ ┻━┻  ";
                    return emoji + root.workedHours;
                }

                pointSize: Style.fontSizeS
                font.bold: true
                Layout.alignment: Qt.AlignVCenter

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        openFileProcess.running = false;
                        openFileProcess.running = true;
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.topMargin: Style.marginM
                Layout.bottomMargin: Style.marginM
                Layout.preferredWidth: 1
                color: Color.mSurfaceVariant
            }

            Rectangle {
                Layout.preferredWidth: 16
                Layout.preferredHeight: 32
                Layout.alignment: Qt.AlignVCenter
                color: clockInMouse.containsMouse ? Color.mSurfaceVariant : "transparent"
                radius: Style.radiusS

                MouseArea {
                    id: clockInMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.executeLog("in")
                }

                NIcon {
                    anchors.centerIn: parent
                    icon: "coffee"
                    color: Color.mOnSurface
                    width: Style.iconSizeM
                    height: Style.iconSizeM
                }
            }

            Rectangle {
                Layout.preferredWidth: 16
                Layout.preferredHeight: 32
                Layout.alignment: Qt.AlignVCenter
                color: logWorkMouse.containsMouse ? Color.mSurfaceVariant : "transparent"
                radius: Style.radiusS

                MouseArea {
                    id: logWorkMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.executeLog("work")
                }

                NIcon {
                    anchors.centerIn: parent
                    icon: "cpu"
                    color: Color.mOnSurface
                    width: Style.iconSizeM
                    height: Style.iconSizeM
                }
            }
        }
    }
  }
