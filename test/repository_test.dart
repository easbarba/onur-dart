import 'package:test/test.dart';

import 'package:onur/repository.dart';

void main() {
  test('has correct count of configurations found', () async {
    var found = await Repository().all();
    expect(found.length, 5);
  });
}
