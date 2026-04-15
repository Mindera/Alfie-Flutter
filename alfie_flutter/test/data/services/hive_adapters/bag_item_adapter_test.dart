import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/services/hive_adapters/bag_item_adapter.dart'; // Adjust path if necessary
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late BagItemAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;
  late MockProduct mockProduct;

  setUp(() {
    adapter = BagItemAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
    mockProduct = MockProduct();
  });

  group('BagItemAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 15);
    });

    test('write() should correctly serialize BagItem to binary', () {
      final bagItem = BagItem(product: mockProduct, quantity: 3);

      adapter.write(mockWriter, bagItem);

      verify(() => mockWriter.write<Product>(mockProduct)).called(1);

      verify(() => mockWriter.writeInt(3)).called(1);
    });

    test('read() should correctly deserialize binary to BagItem', () {
      when(() => mockReader.read()).thenReturn(mockProduct);
      when(() => mockReader.readInt()).thenReturn(5);

      final result = adapter.read(mockReader);

      expect(result.product, mockProduct);
      expect(result.quantity, 5);

      verifyInOrder([() => mockReader.read(), () => mockReader.readInt()]);
    });
  });
}
