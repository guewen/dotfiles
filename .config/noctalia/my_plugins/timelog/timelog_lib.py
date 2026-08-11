from datetime import datetime

def parse_entries(lines):
    """Return list of (datetime, label, display_str) for valid log lines.
    display_str is the line with the date prefix stripped ("HH:MM: label").
    """
    entries = []
    for line in lines:
        stripped = line.strip()
        if not stripped:
            continue
        parts = stripped.split(": ", 1)
        if len(parts) != 2:
            continue
        try:
            dt = datetime.strptime(parts[0], "%Y-%m-%d %H:%M")
        except ValueError:
            continue
        entries.append((dt, parts[1], stripped[11:]))
    return entries

def is_break(label):
    return label.endswith("**") or label.endswith("***")

def compute_daily(entries, today):
    """Return (total_seconds, last_time, display_lines) for today's entries."""
    total_seconds = 0
    last_time = None
    display_lines = []
    for dt, label, display in entries:
        if dt.strftime("%Y-%m-%d") != today:
            continue
        display_lines.append(display)
        if last_time is not None and not is_break(label):
            total_seconds += (dt - last_time).total_seconds()
        last_time = dt
    return total_seconds, last_time, display_lines

def compute_weekly(entries, start_of_week):
    """Return total worked seconds from start_of_week."""
    total_seconds = 0
    last_time = None
    for dt, label, _ in entries:
        if dt < start_of_week:
            continue
        if last_time is not None and last_time.date() == dt.date() and not is_break(label):
            total_seconds += (dt - last_time).total_seconds()
        last_time = dt
    return total_seconds

def format_duration(seconds):
    h = int(seconds // 3600)
    m = int((seconds % 3600) // 60)
    return "{}h {:02d}m".format(h, m)
