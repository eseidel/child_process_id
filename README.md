Demonstrates a bug in the `dart` wrapper where it's not possible to kill
a child process once you start it because the parent gets a differnet pid
than the child actually is (presumably there is a wrapper process in between
which exits instead of replacing its pid with the child?).

This bug may only apply to windows?

## Steps to reproduce
```
dart run bin/parent.dart
```

The child should exit after 5 seconds, but it doesn't.