import 'package:args/args.dart';

import 'package:onur/parse.dart';

void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addCommand('grab');
  parser.addCommand('backup');
  parser.addFlag("help",
      abbr: "h", negatable: false, help: 'display this help info');
  var results = parser.parse(arguments);
  var msg = "Usage: onur [options]\n ${parser.usage}";

  if (results.command?.name == null) {
    print(msg);
    return;
  }

  if (results.flag("help")) {
    print(msg);
    return;
  }

  if (results.command?.name == "grab") {
    await Parse().multi();
  }

  if (results.command?.name == "backup") {
    print("backin up ${results.command?.arguments}");
  }
}
