import '../../brands/fragments/brand_fragment.graphql.dart';
import '../../fragments/attributes_fragment.graphql.dart';
import '../../fragments/colour_fragment.graphql.dart';
import '../../fragments/image_fragment.graphql.dart';
import '../../fragments/media_fragment.graphql.dart';
import '../../fragments/money_fragment.graphql.dart';
import '../../fragments/price_fragment.graphql.dart';
import '../../fragments/price_range_fragment.graphql.dart';
import '../../fragments/size_fragment.graphql.dart';
import '../../fragments/variant_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$ProductFragment {
  Fragment$ProductFragment({
    required this.id,
    required this.styleNumber,
    required this.name,
    required this.brand,
    this.priceRange,
    required this.shortDescription,
    this.longDescription,
    required this.slug,
    this.attributes,
    required this.defaultVariant,
    required this.variants,
    this.colours,
    this.$__typename = 'Product',
  });

  factory Fragment$ProductFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$styleNumber = json['styleNumber'];
    final l$name = json['name'];
    final l$brand = json['brand'];
    final l$priceRange = json['priceRange'];
    final l$shortDescription = json['shortDescription'];
    final l$longDescription = json['longDescription'];
    final l$slug = json['slug'];
    final l$attributes = json['attributes'];
    final l$defaultVariant = json['defaultVariant'];
    final l$variants = json['variants'];
    final l$colours = json['colours'];
    final l$$__typename = json['__typename'];
    return Fragment$ProductFragment(
      id: (l$id as String),
      styleNumber: (l$styleNumber as String),
      name: (l$name as String),
      brand: Fragment$BrandFragment.fromJson((l$brand as Map<String, dynamic>)),
      priceRange: l$priceRange == null
          ? null
          : Fragment$PriceRangeFragment.fromJson(
              (l$priceRange as Map<String, dynamic>),
            ),
      shortDescription: (l$shortDescription as String),
      longDescription: (l$longDescription as String?),
      slug: (l$slug as String),
      attributes: (l$attributes as List<dynamic>?)
          ?.map(
            (e) => Fragment$AttributesFragment.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      defaultVariant: Fragment$VariantFragment.fromJson(
        (l$defaultVariant as Map<String, dynamic>),
      ),
      variants: (l$variants as List<dynamic>)
          .map(
            (e) =>
                Fragment$VariantFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      colours: (l$colours as List<dynamic>?)
          ?.map(
            (e) =>
                Fragment$ColourFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String styleNumber;

  final String name;

  final Fragment$BrandFragment brand;

  final Fragment$PriceRangeFragment? priceRange;

  final String shortDescription;

  final String? longDescription;

  final String slug;

  final List<Fragment$AttributesFragment>? attributes;

  final Fragment$VariantFragment defaultVariant;

  final List<Fragment$VariantFragment> variants;

  final List<Fragment$ColourFragment>? colours;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$styleNumber = styleNumber;
    _resultData['styleNumber'] = l$styleNumber;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$brand = brand;
    _resultData['brand'] = l$brand.toJson();
    final l$priceRange = priceRange;
    _resultData['priceRange'] = l$priceRange?.toJson();
    final l$shortDescription = shortDescription;
    _resultData['shortDescription'] = l$shortDescription;
    final l$longDescription = longDescription;
    _resultData['longDescription'] = l$longDescription;
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$attributes = attributes;
    _resultData['attributes'] = l$attributes?.map((e) => e.toJson()).toList();
    final l$defaultVariant = defaultVariant;
    _resultData['defaultVariant'] = l$defaultVariant.toJson();
    final l$variants = variants;
    _resultData['variants'] = l$variants.map((e) => e.toJson()).toList();
    final l$colours = colours;
    _resultData['colours'] = l$colours?.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$styleNumber = styleNumber;
    final l$name = name;
    final l$brand = brand;
    final l$priceRange = priceRange;
    final l$shortDescription = shortDescription;
    final l$longDescription = longDescription;
    final l$slug = slug;
    final l$attributes = attributes;
    final l$defaultVariant = defaultVariant;
    final l$variants = variants;
    final l$colours = colours;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$styleNumber,
      l$name,
      l$brand,
      l$priceRange,
      l$shortDescription,
      l$longDescription,
      l$slug,
      l$attributes == null ? null : Object.hashAll(l$attributes.map((v) => v)),
      l$defaultVariant,
      Object.hashAll(l$variants.map((v) => v)),
      l$colours == null ? null : Object.hashAll(l$colours.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ProductFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$styleNumber = styleNumber;
    final lOther$styleNumber = other.styleNumber;
    if (l$styleNumber != lOther$styleNumber) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$brand = brand;
    final lOther$brand = other.brand;
    if (l$brand != lOther$brand) {
      return false;
    }
    final l$priceRange = priceRange;
    final lOther$priceRange = other.priceRange;
    if (l$priceRange != lOther$priceRange) {
      return false;
    }
    final l$shortDescription = shortDescription;
    final lOther$shortDescription = other.shortDescription;
    if (l$shortDescription != lOther$shortDescription) {
      return false;
    }
    final l$longDescription = longDescription;
    final lOther$longDescription = other.longDescription;
    if (l$longDescription != lOther$longDescription) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$attributes = attributes;
    final lOther$attributes = other.attributes;
    if (l$attributes != null && lOther$attributes != null) {
      if (l$attributes.length != lOther$attributes.length) {
        return false;
      }
      for (int i = 0; i < l$attributes.length; i++) {
        final l$attributes$entry = l$attributes[i];
        final lOther$attributes$entry = lOther$attributes[i];
        if (l$attributes$entry != lOther$attributes$entry) {
          return false;
        }
      }
    } else if (l$attributes != lOther$attributes) {
      return false;
    }
    final l$defaultVariant = defaultVariant;
    final lOther$defaultVariant = other.defaultVariant;
    if (l$defaultVariant != lOther$defaultVariant) {
      return false;
    }
    final l$variants = variants;
    final lOther$variants = other.variants;
    if (l$variants.length != lOther$variants.length) {
      return false;
    }
    for (int i = 0; i < l$variants.length; i++) {
      final l$variants$entry = l$variants[i];
      final lOther$variants$entry = lOther$variants[i];
      if (l$variants$entry != lOther$variants$entry) {
        return false;
      }
    }
    final l$colours = colours;
    final lOther$colours = other.colours;
    if (l$colours != null && lOther$colours != null) {
      if (l$colours.length != lOther$colours.length) {
        return false;
      }
      for (int i = 0; i < l$colours.length; i++) {
        final l$colours$entry = l$colours[i];
        final lOther$colours$entry = lOther$colours[i];
        if (l$colours$entry != lOther$colours$entry) {
          return false;
        }
      }
    } else if (l$colours != lOther$colours) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$ProductFragment
    on Fragment$ProductFragment {
  CopyWith$Fragment$ProductFragment<Fragment$ProductFragment> get copyWith =>
      CopyWith$Fragment$ProductFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$ProductFragment<TRes> {
  factory CopyWith$Fragment$ProductFragment(
    Fragment$ProductFragment instance,
    TRes Function(Fragment$ProductFragment) then,
  ) = _CopyWithImpl$Fragment$ProductFragment;

  factory CopyWith$Fragment$ProductFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ProductFragment;

  TRes call({
    String? id,
    String? styleNumber,
    String? name,
    Fragment$BrandFragment? brand,
    Fragment$PriceRangeFragment? priceRange,
    String? shortDescription,
    String? longDescription,
    String? slug,
    List<Fragment$AttributesFragment>? attributes,
    Fragment$VariantFragment? defaultVariant,
    List<Fragment$VariantFragment>? variants,
    List<Fragment$ColourFragment>? colours,
    String? $__typename,
  });
  CopyWith$Fragment$BrandFragment<TRes> get brand;
  CopyWith$Fragment$PriceRangeFragment<TRes> get priceRange;
  TRes attributes(
    Iterable<Fragment$AttributesFragment>? Function(
      Iterable<
        CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>
      >?,
    )
    _fn,
  );
  CopyWith$Fragment$VariantFragment<TRes> get defaultVariant;
  TRes variants(
    Iterable<Fragment$VariantFragment> Function(
      Iterable<CopyWith$Fragment$VariantFragment<Fragment$VariantFragment>>,
    )
    _fn,
  );
  TRes colours(
    Iterable<Fragment$ColourFragment>? Function(
      Iterable<CopyWith$Fragment$ColourFragment<Fragment$ColourFragment>>?,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$ProductFragment<TRes>
    implements CopyWith$Fragment$ProductFragment<TRes> {
  _CopyWithImpl$Fragment$ProductFragment(this._instance, this._then);

  final Fragment$ProductFragment _instance;

  final TRes Function(Fragment$ProductFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? styleNumber = _undefined,
    Object? name = _undefined,
    Object? brand = _undefined,
    Object? priceRange = _undefined,
    Object? shortDescription = _undefined,
    Object? longDescription = _undefined,
    Object? slug = _undefined,
    Object? attributes = _undefined,
    Object? defaultVariant = _undefined,
    Object? variants = _undefined,
    Object? colours = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$ProductFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      styleNumber: styleNumber == _undefined || styleNumber == null
          ? _instance.styleNumber
          : (styleNumber as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      brand: brand == _undefined || brand == null
          ? _instance.brand
          : (brand as Fragment$BrandFragment),
      priceRange: priceRange == _undefined
          ? _instance.priceRange
          : (priceRange as Fragment$PriceRangeFragment?),
      shortDescription:
          shortDescription == _undefined || shortDescription == null
          ? _instance.shortDescription
          : (shortDescription as String),
      longDescription: longDescription == _undefined
          ? _instance.longDescription
          : (longDescription as String?),
      slug: slug == _undefined || slug == null
          ? _instance.slug
          : (slug as String),
      attributes: attributes == _undefined
          ? _instance.attributes
          : (attributes as List<Fragment$AttributesFragment>?),
      defaultVariant: defaultVariant == _undefined || defaultVariant == null
          ? _instance.defaultVariant
          : (defaultVariant as Fragment$VariantFragment),
      variants: variants == _undefined || variants == null
          ? _instance.variants
          : (variants as List<Fragment$VariantFragment>),
      colours: colours == _undefined
          ? _instance.colours
          : (colours as List<Fragment$ColourFragment>?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$BrandFragment<TRes> get brand {
    final local$brand = _instance.brand;
    return CopyWith$Fragment$BrandFragment(local$brand, (e) => call(brand: e));
  }

  CopyWith$Fragment$PriceRangeFragment<TRes> get priceRange {
    final local$priceRange = _instance.priceRange;
    return local$priceRange == null
        ? CopyWith$Fragment$PriceRangeFragment.stub(_then(_instance))
        : CopyWith$Fragment$PriceRangeFragment(
            local$priceRange,
            (e) => call(priceRange: e),
          );
  }

  TRes attributes(
    Iterable<Fragment$AttributesFragment>? Function(
      Iterable<
        CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>
      >?,
    )
    _fn,
  ) => call(
    attributes: _fn(
      _instance.attributes?.map(
        (e) => CopyWith$Fragment$AttributesFragment(e, (i) => i),
      ),
    )?.toList(),
  );

  CopyWith$Fragment$VariantFragment<TRes> get defaultVariant {
    final local$defaultVariant = _instance.defaultVariant;
    return CopyWith$Fragment$VariantFragment(
      local$defaultVariant,
      (e) => call(defaultVariant: e),
    );
  }

  TRes variants(
    Iterable<Fragment$VariantFragment> Function(
      Iterable<CopyWith$Fragment$VariantFragment<Fragment$VariantFragment>>,
    )
    _fn,
  ) => call(
    variants: _fn(
      _instance.variants.map(
        (e) => CopyWith$Fragment$VariantFragment(e, (i) => i),
      ),
    ).toList(),
  );

  TRes colours(
    Iterable<Fragment$ColourFragment>? Function(
      Iterable<CopyWith$Fragment$ColourFragment<Fragment$ColourFragment>>?,
    )
    _fn,
  ) => call(
    colours: _fn(
      _instance.colours?.map(
        (e) => CopyWith$Fragment$ColourFragment(e, (i) => i),
      ),
    )?.toList(),
  );
}

class _CopyWithStubImpl$Fragment$ProductFragment<TRes>
    implements CopyWith$Fragment$ProductFragment<TRes> {
  _CopyWithStubImpl$Fragment$ProductFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? styleNumber,
    String? name,
    Fragment$BrandFragment? brand,
    Fragment$PriceRangeFragment? priceRange,
    String? shortDescription,
    String? longDescription,
    String? slug,
    List<Fragment$AttributesFragment>? attributes,
    Fragment$VariantFragment? defaultVariant,
    List<Fragment$VariantFragment>? variants,
    List<Fragment$ColourFragment>? colours,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$BrandFragment<TRes> get brand =>
      CopyWith$Fragment$BrandFragment.stub(_res);

  CopyWith$Fragment$PriceRangeFragment<TRes> get priceRange =>
      CopyWith$Fragment$PriceRangeFragment.stub(_res);

  attributes(_fn) => _res;

  CopyWith$Fragment$VariantFragment<TRes> get defaultVariant =>
      CopyWith$Fragment$VariantFragment.stub(_res);

  variants(_fn) => _res;

  colours(_fn) => _res;
}

const fragmentDefinitionProductFragment = FragmentDefinitionNode(
  name: NameNode(value: 'ProductFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Product'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'styleNumber'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'brand'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'BrandFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'priceRange'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'PriceRangeFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'shortDescription'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'longDescription'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'slug'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'attributes'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'AttributesFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'defaultVariant'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'VariantFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'variants'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'VariantFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'colours'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'ColourFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentProductFragment = DocumentNode(
  definitions: [
    fragmentDefinitionProductFragment,
    fragmentDefinitionBrandFragment,
    fragmentDefinitionPriceRangeFragment,
    fragmentDefinitionMoneyFragment,
    fragmentDefinitionAttributesFragment,
    fragmentDefinitionVariantFragment,
    fragmentDefinitionSizeTreeFragment,
    fragmentDefinitionSizeFragment,
    fragmentDefinitionSizeGuideTreeFragment,
    fragmentDefinitionSizeGuideFragment,
    fragmentDefinitionPriceFragment,
    fragmentDefinitionColourFragment,
    fragmentDefinitionImageFragment,
    fragmentDefinitionMediaFragment,
  ],
);

extension ClientExtension$Fragment$ProductFragment on graphql.GraphQLClient {
  void writeFragment$ProductFragment({
    required Fragment$ProductFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'ProductFragment',
        document: documentNodeFragmentProductFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$ProductFragment? readFragment$ProductFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'ProductFragment',
          document: documentNodeFragmentProductFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$ProductFragment.fromJson(result);
  }
}
