---
description: Resume the last interrupted task by reading `.sylvain/todo.json`.
agent: sylvain
---

# /resume-task

1. Load `.sylvain/todo.json`.
2. Find the most recent task with status `in-progress` or `blocked`.
3. Summarise where work stopped and why.
4. Propose the next concrete step.
5. On user confirmation, hand off to the appropriate agent.

If no incomplete task exists, say so and stop.
