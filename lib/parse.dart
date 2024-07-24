import 'dart:convert';
import 'dart:io';

import 'repository.dart';

class Parse {
  Future<void> multi() async {
    final allConfigs = await Repository().all();

    try {
      for (FileSystemEntity cfg in allConfigs) {
        final jsonCfg = jsonDecode(cfg.path);
        print(jsonCfg);
      }
    } catch (e) {
      print(e);
    }
  }
}
