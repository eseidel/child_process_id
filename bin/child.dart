import 'dart:async';
import 'dart:io';

void main() {
  print("Child process started (pid: $pid)");
  Timer.periodic(Duration(seconds: 1), (timer) {
    print("Child process running (pid: $pid)");
  });
}
