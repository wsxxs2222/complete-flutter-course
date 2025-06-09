import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

FakeProductsRepository getTestRepository() {
  return FakeProductsRepository(shouldDelay: false);
}

void main() {
  test('test get product list', () {
    final fakeProductsRepository = getTestRepository();
    expect(fakeProductsRepository.getProductsList(), kTestProducts);
  });

  test('test get product by id', () {
    final fakeProductsRepository = getTestRepository();
    expect(fakeProductsRepository.getProduct('1'), kTestProducts[0]);
  });

  test('test get product with id out of range', () {
    final fakeProductsRepository = getTestRepository();
    expect(fakeProductsRepository.getProduct('100'), null);
  });

  test('fetch product list', () async {
    final fakeProductsRepository = getTestRepository();
    expect(await fakeProductsRepository.fetchProductsList(), kTestProducts);
  });

  test('watch products emits product list', () async {
    final fakeProductsRepository = getTestRepository();
    expect(fakeProductsRepository.watchProductsList(), emits(kTestProducts));
  });

  test('watch product emits the product with corresponding id', () async {
    final fakeProductsRepository = getTestRepository();
    expect(fakeProductsRepository.watchProduct('1'), emits(kTestProducts[0]));
  });

  test('watch product emits null if id is out of range', () async {
    final fakeProductsRepository = getTestRepository();
    expect(fakeProductsRepository.watchProduct('100'), emits(null));
  });
}
