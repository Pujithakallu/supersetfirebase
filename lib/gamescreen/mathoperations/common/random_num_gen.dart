import 'dart:math';

int getRandomNumberWithLimit(int upperLimit) {
  Random random = Random();
  return random.nextInt(99999999)%upperLimit;
}

int getRandomNumberWithLimitNotEqual(int upperLimit, int uniq_num) {
  Random random = Random();
  int res;

  do {
    res = random.nextInt(upperLimit) + 1;
  } while (res == uniq_num);

  return res;
}

// List<int> getRandomNumbersWithSumLimit(int upperRange, int sumLimit) {
//   Random random = Random();
//
//   // Generate two random numbers within the specified upper range
//   int randomNumber1 = random.nextInt(upperRange) + 1;
//   int remainingLimit = sumLimit - randomNumber1;
//   int randomNumber2 = random.nextInt(min(upperRange + 1, remainingLimit + 1));
//
//   // Return the two random numbers
//   return randomNumber1 > randomNumber2 ? [randomNumber1, randomNumber2]: [randomNumber2, randomNumber1];
// }

List<int> getRandomNumbersWithLimit(int upperRange, int sumLimit) {
  Random random = Random();

  int randomNumber1;
  int randomNumber2;

  do {
    randomNumber1 = random.nextInt(upperRange) + 1;
    int remainingLimit = sumLimit - randomNumber1;
    randomNumber2 = random.nextInt(min(upperRange + 1, remainingLimit + 1));
  } while (randomNumber1 == 0 || randomNumber2 == 0);

  List<int> result = [randomNumber1, randomNumber2];
  result.sort(); // Sort the numbers in ascending order

  return [result[1], result[0]]; // Return [max, min]
}