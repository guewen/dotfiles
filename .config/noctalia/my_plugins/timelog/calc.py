import os
import sys
from datetime import datetime, timedelta

import timelog_lib

log_file = os.path.expanduser("~/.local/share/gtimelog/timelog.txt")
if not os.path.exists(log_file):
    print("false")
    print("0h 00m")
    sys.exit(0)

now = datetime.now()
today = now.strftime("%Y-%m-%d")
start_of_week = (now - timedelta(days=now.weekday())).replace(
    hour=0, minute=0, second=0, microsecond=0
)

with open(log_file) as f:
    entries = timelog_lib.parse_entries(f.readlines())

daily_seconds, last_time_today, today_display = timelog_lib.compute_daily(
    entries, today
)
weekly_seconds = timelog_lib.compute_weekly(entries, start_of_week)

elapsed = (now - last_time_today).total_seconds() if last_time_today else 0
time_str = (
    timelog_lib.format_duration(daily_seconds)
    + " + "
    + timelog_lib.format_duration(elapsed)
)
week_str = timelog_lib.format_duration(weekly_seconds + elapsed)

print("true" if today_display else "false")
print(time_str)

if today_display:
    for line in today_display:
        print(line)
    print("")
    print("Total today: " + time_str)
print("Total week:  " + week_str)
