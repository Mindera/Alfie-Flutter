import 'package:alfie_flutter/graphql/generated/queries/fragments/attributes_fragment.graphql.dart';

extension AttributesMapper on List<Fragment$AttributesFragment>? {
  Map<String, String> toDomain() {
    if (this == null) {
      return {};
    }
    return Map.fromEntries(
      this!.map((attribute) => MapEntry(attribute.key, attribute.value)),
    );
  }
}
