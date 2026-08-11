import os
import subprocess
import sys
import tempfile
from datetime import datetime

import timelog_lib

action = sys.argv[1]
log_file = os.path.expanduser("~/.local/share/gtimelog/timelog.txt")
log_dir = os.path.dirname(log_file)
nl = chr(10)

os.makedirs(log_dir, exist_ok=True)

now = datetime.now()
today_str = now.strftime("%Y-%m-%d")
ts_str = now.strftime("%Y-%m-%d %H:%M:")

lines = []
if os.path.exists(log_file):
    with open(log_file) as f:
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
    last = lines[-1].strip() if lines else ""
    if last.startswith(today_str) and last.endswith(": work"):
        lines[-1] = ts_str + " work" + nl
    else:
        lines.append(ts_str + " work" + nl)

with tempfile.NamedTemporaryFile("w", dir=log_dir, delete=False) as tf:
    tf.writelines(lines)
    tf.flush()
    os.fsync(tf.fileno())
    temp_name = tf.name

os.replace(temp_name, log_file)

daily_seconds, _, today_display = timelog_lib.compute_daily(
    timelog_lib.parse_entries(lines), today_str
)
total_time_str = timelog_lib.format_duration(daily_seconds)

notify_body = (
    "<br>".join(today_display) + "<br><br><b>Total today: " + total_time_str + "</b>"
)
subprocess.run(["notify-send", "-a", "GTimeLog", "GTimeLog", notify_body])
