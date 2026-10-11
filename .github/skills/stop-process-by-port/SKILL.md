---
name: stop-process-by-port
description: "Stop the process listening on a specified port. Use when the user asks to free, kill, terminate, or stop a port; ask for the port if omitted, identify the exact listener, and get confirmation before stopping it."
argument-hint: "Port to free (optional)"
user-invocable: true
---

# stop-process-by-port

Safely stop only the process confirmed to be listening on the requested port.

## Workflow

1. **Get the port.** If omitted, ask the user. Validate an integer from `1` to `65535`; never infer a port from a service name.
2. **Find listeners.** Use the platform's listener inspection command (`lsof` on macOS; `ss` or `lsof` on Linux). Do not use `sudo` to bypass access restrictions.
3. **Identify each process.** Check PID, executable, owner, parent, and working directory where available. Avoid exposing full command lines that may contain secrets. If there are multiple listeners, report each separately.
4. **Handle containers safely.** If the listener is Docker or a system proxy, identify the container publishing the port. Never kill the proxy process; ask before stopping the identified container.
5. **Confirm the exact target.** Tell the user the port, PID, process name, and relevant context, then ask for explicit confirmation to stop that process. Supplying a port is not confirmation to kill an unidentified process.
6. **Stop gracefully.** After confirmation, send `SIGTERM` to the exact PID. Never use `killall`, broad `pkill` patterns, or commands that terminate every PID associated with the port.
7. **Verify.** Check the port again and report whether it is free. If the process remains, explain why and ask again before escalating to `SIGKILL`.

## Safety rules

- Never kill PID 1, a system process, VS Code/Copilot, the agent's shell/terminal, or another user's process.
- If identity is uncertain, permissions are insufficient, or the PID changed, stop and re-inspect; request confirmation again.
- If no process is listening, report that and take no action.
- Confirm each target separately when multiple processes listen; do not assume they belong to one app.
- Do not restart the process unless the user separately asks.
- End with a concise report of the port, target process, and result.
