int get_op_result(String sign, int f, int s) {
  switch (sign) {
    case '+':
      return f + s;
    case '-':
      return f - s;
    case 'x':
      return f * s;
    case '÷':
      return f ~/ s; // Performing integer division
    default:
      return 0;
  }
}