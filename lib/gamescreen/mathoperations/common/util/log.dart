import 'dart:developer';

void printInBox(String message) {
  final lines = message.split('\n');
  final maxLength =
      lines.map((line) => line.length).reduce((a, b) => a > b ? a : b);
  final border = '+-${'-' * maxLength}-+';

  log(border);
  for (final line in lines) {
    log('| ${line.padRight(maxLength)} |');
  }
  log(border);
}
