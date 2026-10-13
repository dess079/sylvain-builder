---
name: provision-cloudflare-tunnel
description: Provisions a Cloudflare Tunnel for a user-confirmed target repository, hostname, service and credentials location.
argument-hint: "<app name to expose>"
user-invocable: true
disable-model-invocation: false
---

# provision-cloudflare-tunnel

## Before action

Confirm the target repository/deployment configuration, service name and port,
public hostname and zone, routing needs, credentials directory, and whether the
target has a documented registry or Cloudflare guide. Never infer these values
from another repository or a personal default domain.

## Execution

1. Read the target repository's own tunnel/deployment documentation when it
   exists; otherwise state the proposed configuration before creating resources.
2. Create the tunnel, retain its UUID and place credentials in the confirmed
   secure location.
3. Create ingress and DNS routing for the confirmed hostname.
4. Add the tunnel service/configuration to the confirmed deployment target.
5. Update a documented target-repository registry only when it exists and is in
   scope.
6. Start the service and verify HTTPS resolution.

## Boundaries

- One dedicated tunnel per service unless the user explicitly approves shared
  hostname/path routing.
- Never expose credentials, loosen filesystem permissions or retry a failed
  DNS/API operation blindly.
- On failure, report the exact command/API error and stop for direction.
