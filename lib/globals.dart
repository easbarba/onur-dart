import 'dart:io';

class Globals {
  Future<Directory> onurDir() async {
    final result = Directory("/home/easbarba/.config/onur");

    if (!await result.exists()) {
      print("Onur directory at \$XDG_CONFIG_HOME was not found");
      exit(1);
    }

    return result;
  }
}
