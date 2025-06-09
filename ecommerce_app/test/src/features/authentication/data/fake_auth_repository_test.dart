import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

FakeAuthRepository getTestFakeAuthRepository() =>
    FakeAuthRepository(shouldDelay: false);
void main() {
  const testEmail = 'test@gmail.com';
  const testPassword = '123';
  final expectedCreatedUser =
      AppUser(uid: testEmail.split('').reversed.join(), email: testEmail);
  group('fake auth repo tests', () {
    test('test init user is null', () async {
      final testAuthRepository = getTestFakeAuthRepository();
      expect(testAuthRepository.currentUser, null);
      expect(testAuthRepository.authStateChanges(), emits(null));
    });
    test('current user updates after signin', () async {
      final testAuthRepository = getTestFakeAuthRepository();
      await testAuthRepository.signInWithEmailAndPassword(
          testEmail, testPassword);
      expect(testAuthRepository.currentUser, expectedCreatedUser);
      expect(testAuthRepository.authStateChanges(), emits(expectedCreatedUser));
    });
    test('current user is null after signout', () async {
      final testAuthRepository = getTestFakeAuthRepository();
      await testAuthRepository.signInWithEmailAndPassword(
          testEmail, testPassword);
      expect(testAuthRepository.currentUser, expectedCreatedUser);
      await testAuthRepository.signOut();
      expect(testAuthRepository.currentUser, null);
      expect(testAuthRepository.authStateChanges(), emits(null));
    });
  });
  test('signin errors after repo is disposed', () async {
    final testAuthRepository = getTestFakeAuthRepository();
    testAuthRepository.dispose();
    expect(
        () => testAuthRepository.signInWithEmailAndPassword(
            testEmail, testPassword),
        throwsStateError);
  });
}
