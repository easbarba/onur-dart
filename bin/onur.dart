import 'package:args/args.dart';

// import 'package:onur/onur.dart' as onur;

void main(List<String> arguments) {
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
    print('grabbing');
  }

  if (results.command?.name == "backup") {
    print("backin up ${results.command?.arguments}");
  }
}
