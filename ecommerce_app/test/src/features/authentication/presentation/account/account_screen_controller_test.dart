// ignore: library_annotations
@Timeout(Duration(
  milliseconds: 500,
))
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController accountScreenController;
  setUp(() {
    authRepository = MockAuthRepository();
    accountScreenController =
        AccountScreenController(authRepository: authRepository);
  });
  tearDown(() {
    authRepository.dispose();
  });
  test('signout success flow', () async {
    when(() => authRepository.signOut()).thenAnswer(
      (_) async => Future.value(null),
    );
    expect(
      accountScreenController.state,
      AsyncValue<void>.data(null),
    );
    expectLater(
        accountScreenController.stream,
        emitsInOrder([
          AsyncValue<void>.loading(),
          AsyncValue<void>.data(null),
        ]));
    accountScreenController.signOut();
  });

  test('failed signout flow', () async {
    when(() => authRepository.signOut()).thenThrow(throwsStateError);
    expectLater(
        accountScreenController.stream,
        emitsInOrder([
          AsyncValue<void>.loading(),
          predicate<AsyncValue<void>>((state) {
            return state.hasError == true;
          }),
        ]));
    accountScreenController.signOut();
  }, timeout: Timeout(Duration(milliseconds: 500)));
}
