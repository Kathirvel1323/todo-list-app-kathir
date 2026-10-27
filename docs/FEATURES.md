# To-Do List enhancements

- Filter tasks by All, Active, or Completed.
- Clear all completed tasks in one action.
- Retains adding non-empty tasks, completion toggles, swipe deletion, and individual delete buttons.

## Structure

- `lib/main.dart`: task model, filtering, and UI state.
- `main.dart`: optional root entrypoint forwarding to `lib/main.dart`.
- `test/widget_test.dart`: add, complete, count, and delete flow.

## Demo checklist

1. Add a task and mark it complete.
2. Switch between All, Active, and Completed.
3. Clear completed items, then remove an active item.
