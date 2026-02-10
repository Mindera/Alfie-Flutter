import 'package:alfie_flutter/graphql/generated/queries/fragments/attributes_fragment.graphql.dart';

/// Converts a GraphQL List of Attributes into a Map.
extension AttributesMapper on List<Fragment$AttributesFragment>? {
  /// Converts this list of attributes fragment to a [Map].
  Map<String, String>? toDomain() {
    if (this == null) return null;

    return {for (final attribute in this!) attribute.key: attribute.value};
  }
}
