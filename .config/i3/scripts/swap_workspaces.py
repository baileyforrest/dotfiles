#!/usr/bin/env python3

import i3
import sys

active_outputs = [output for output in i3.get_outputs() if output['active']]

# This script only supports 2 outputs.
if len(active_outputs) != 2:
    sys.exit(1)

# Get active workspaces
active_wss = map(lambda x: x['current_workspace'], active_outputs)

# Get focused workspace
focused_ws = list(filter(lambda x: x['focused'], i3.get_workspaces()))
assert(len(focused_ws) == 1)
focused_ws = focused_ws[0]['name']

# Swap all workspaces
for ws in i3.get_workspaces():
    i3.workspace(ws['name'])
    i3.command('move', 'workspace to output right')

# Place old active workspaces back to front
for ws in active_wss:
    i3.workspace(ws)

# Switch to last focused workspace
i3.workspace(focused_ws)
