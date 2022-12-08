import 'dart:async';
import 'dart:convert';

// This depends on package:process just for convenience, but
// the same bug should repro with raw dart:io calls.
import 'package:process/process.dart';

void main(List<String> arguments) {
  var processManager = const LocalProcessManager();
  print("Starting child process...");
  var process = processManager.start(['dart', 'bin/child.dart']);
  process.then((process) {
    process.stdout
        .transform(utf8.decoder)
        .transform(LineSplitter())
        .listen((event) {
      print("child: $event");
    });
    process.stderr
        .transform(utf8.decoder)
        .transform(LineSplitter())
        .listen((event) {
      print("child Error: $event");
    });
    print("Child process started: ${process.pid}");

    processManager
        .run(["tasklist", "/v", "/fi", "pid eq ${process.pid}"]).then((result) {
      print(
          "tasklist /v /fi \"pid eq ${process.pid}\" result:\n${result.stdout}");
    });

    print("Waiting 5 seconds");
    Timer(Duration(seconds: 5), () {
      print("Killing child process ${process.pid}");
      process.kill();
    });
  });
}
