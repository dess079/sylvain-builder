$todoPath = '.sylvain/todo.json'
$summary = ''

if (Test-Path $todoPath) {
  $todo = Get-Content -Raw $todoPath | ConvertFrom-Json
  $selected = @($todo.tasks | Where-Object { $_.id -eq $todo.currentTaskId })
  $selected += @($todo.tasks | Where-Object { $_.status -eq 'blocked' -and $_.id -ne $todo.currentTaskId })
  $selected = @($selected | Select-Object -First 3)
  if ($selected.Count -gt 0) {
    $lines = $selected | ForEach-Object { "$($_.id): $($_.status) — $($_.title)" }
    $summary = "Active sylvain todos:`n" + ($lines -join "`n")
  }
}

@{ hookSpecificOutput = @{ hookEventName = 'SessionStart'; additionalContext = $summary } } | ConvertTo-Json -Compress
