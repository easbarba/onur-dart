import 'dart:io';

import 'package:logging/logging.dart';

import 'globals.dart';

class Repository {
  Future<List<FileSystemEntity>> all() async {
    final dir = await Globals().onurDir();
    Logger.root.level = Level.ALL;
    final logger = Logger("mylogger");

    var result = dir
        .list(followLinks: true)
        .where((c) => c.path.contains(".json"))
        .asyncExpand((c) async* {
      try {
        final res = await c.exists();
        if (res) {
          yield c;
        }
      } catch (e) {
        logger.warning(e);
      }
    }).asyncExpand((c) async* {
      try {
        var res = await File(c.path).length() == 0;
        if (res) {
          yield c;
        }
      } catch (e) {
        // PathNotFoundException
        logger.warning(e);
      }
    });

    return result.toList();
  }
}
