import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

void logApp(dynamic data) {
  if (kDebugMode) {
    print(data);
    inspect(data);
  }
}

String getUuid() {
  String uid = const Uuid().v4();
  return uid;
}
