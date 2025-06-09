Future<void> addDelay(bool shouldDelay, [int delayAmount = 2000]) async {
  if (shouldDelay) {
    await Future.delayed(Duration(milliseconds: delayAmount));
  }
}
