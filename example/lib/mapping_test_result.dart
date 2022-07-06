import 'dart:typed_data';

import 'package:flutter/material.dart';

enum TestStatus { ok, pending, failed, complete }

typedef TestStep = Future<MappingTestStepResult> Function();

const String nothing = '-';

class MappingTestStepResult {
  final String name;
  final String description;
  final TestStatus status;
  final dynamic error;

  const MappingTestStepResult(
    this.name,
    this.description,
    this.status, {
    this.error = nothing,
  });

  factory MappingTestStepResult.fromSnapshot(
      AsyncSnapshot<MappingTestStepResult> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const MappingTestStepResult(
            'Not started', nothing, TestStatus.ok);
      case ConnectionState.waiting:
        return const MappingTestStepResult(
            'Executing', nothing, TestStatus.pending);
      case ConnectionState.done:
        // if (snapshot.hasData) {
        //   return snapshot.data;
        // }
        return snapshot.error as MappingTestStepResult;
      case ConnectionState.active:
        throw 'Unsupported state ${snapshot.connectionState}';
    }
  }

  static const TextStyle bold = TextStyle(fontWeight: FontWeight.bold);
  static const MappingTestStepResult complete = MappingTestStepResult(
    'Test complete',
    nothing,
    TestStatus.complete,
  );

  Widget asWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Step: $name', style: bold),
        Text(description),
        const Text(' '),
        Text('Error: ${_toString(error)}'),
        const Text(' '),
        Text(
          status.toString().substring('TestStatus.'.length),
          key: ValueKey<String>(
              status == TestStatus.pending ? 'nostatus' : 'status'),
          style: bold,
        ),
      ],
    );
  }

  String _toString(dynamic message) {
    if (message is ByteData)
      return message.buffer
          .asUint8List(message.offsetInBytes, message.lengthInBytes)
          .toString();
    else
      return '$message';
  }
}
