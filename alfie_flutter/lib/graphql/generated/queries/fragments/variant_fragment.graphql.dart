import 'attributes_fragment.graphql.dart';
import 'money_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'price_fragment.graphql.dart';
import 'size_fragment.graphql.dart';

class Fragment$VariantFragment {
  Fragment$VariantFragment({
    required this.sku,
    this.size,
    this.colour,
    this.attributes,
    required this.stock,
    required this.price,
    this.$__typename = 'Variant',
  });

  factory Fragment$VariantFragment.fromJson(Map<String, dynamic> json) {
    final l$sku = json['sku'];
    final l$size = json['size'];
    final l$colour = json['colour'];
    final l$attributes = json['attributes'];
    final l$stock = json['stock'];
    final l$price = json['price'];
    final l$$__typename = json['__typename'];
    return Fragment$VariantFragment(
      sku: (l$sku as String),
      size: l$size == null
          ? null
          : Fragment$SizeTreeFragment.fromJson(
              (l$size as Map<String, dynamic>),
            ),
      colour: l$colour == null
          ? null
          : Fragment$VariantFragment$colour.fromJson(
              (l$colour as Map<String, dynamic>),
            ),
      attributes: (l$attributes as List<dynamic>?)
          ?.map(
            (e) => Fragment$AttributesFragment.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      stock: (l$stock as int),
      price: Fragment$PriceFragment.fromJson((l$price as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String sku;

  final Fragment$SizeTreeFragment? size;

  final Fragment$VariantFragment$colour? colour;

  final List<Fragment$AttributesFragment>? attributes;

  final int stock;

  final Fragment$PriceFragment price;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$sku = sku;
    _resultData['sku'] = l$sku;
    final l$size = size;
    _resultData['size'] = l$size?.toJson();
    final l$colour = colour;
    _resultData['colour'] = l$colour?.toJson();
    final l$attributes = attributes;
    _resultData['attributes'] = l$attributes?.map((e) => e.toJson()).toList();
    final l$stock = stock;
    _resultData['stock'] = l$stock;
    final l$price = price;
    _resultData['price'] = l$price.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$sku = sku;
    final l$size = size;
    final l$colour = colour;
    final l$attributes = attributes;
    final l$stock = stock;
    final l$price = price;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$sku,
      l$size,
      l$colour,
      l$attributes == null ? null : Object.hashAll(l$attributes.map((v) => v)),
      l$stock,
      l$price,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$VariantFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$sku = sku;
    final lOther$sku = other.sku;
    if (l$sku != lOther$sku) {
      return false;
    }
    final l$size = size;
    final lOther$size = other.size;
    if (l$size != lOther$size) {
      return false;
    }
    final l$colour = colour;
    final lOther$colour = other.colour;
    if (l$colour != lOther$colour) {
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
    final l$stock = stock;
    final lOther$stock = other.stock;
    if (l$stock != lOther$stock) {
      return false;
    }
    final l$price = price;
    final lOther$price = other.price;
    if (l$price != lOther$price) {
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

extension UtilityExtension$Fragment$VariantFragment
    on Fragment$VariantFragment {
  CopyWith$Fragment$VariantFragment<Fragment$VariantFragment> get copyWith =>
      CopyWith$Fragment$VariantFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$VariantFragment<TRes> {
  factory CopyWith$Fragment$VariantFragment(
    Fragment$VariantFragment instance,
    TRes Function(Fragment$VariantFragment) then,
  ) = _CopyWithImpl$Fragment$VariantFragment;

  factory CopyWith$Fragment$VariantFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$VariantFragment;

  TRes call({
    String? sku,
    Fragment$SizeTreeFragment? size,
    Fragment$VariantFragment$colour? colour,
    List<Fragment$AttributesFragment>? attributes,
    int? stock,
    Fragment$PriceFragment? price,
    String? $__typename,
  });
  CopyWith$Fragment$SizeTreeFragment<TRes> get size;
  CopyWith$Fragment$VariantFragment$colour<TRes> get colour;
  TRes attributes(
    Iterable<Fragment$AttributesFragment>? Function(
      Iterable<
        CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>
      >?,
    )
    _fn,
  );
  CopyWith$Fragment$PriceFragment<TRes> get price;
}

class _CopyWithImpl$Fragment$VariantFragment<TRes>
    implements CopyWith$Fragment$VariantFragment<TRes> {
  _CopyWithImpl$Fragment$VariantFragment(this._instance, this._then);

  final Fragment$VariantFragment _instance;

  final TRes Function(Fragment$VariantFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? sku = _undefined,
    Object? size = _undefined,
    Object? colour = _undefined,
    Object? attributes = _undefined,
    Object? stock = _undefined,
    Object? price = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$VariantFragment(
      sku: sku == _undefined || sku == null ? _instance.sku : (sku as String),
      size: size == _undefined
          ? _instance.size
          : (size as Fragment$SizeTreeFragment?),
      colour: colour == _undefined
          ? _instance.colour
          : (colour as Fragment$VariantFragment$colour?),
      attributes: attributes == _undefined
          ? _instance.attributes
          : (attributes as List<Fragment$AttributesFragment>?),
      stock: stock == _undefined || stock == null
          ? _instance.stock
          : (stock as int),
      price: price == _undefined || price == null
          ? _instance.price
          : (price as Fragment$PriceFragment),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$SizeTreeFragment<TRes> get size {
    final local$size = _instance.size;
    return local$size == null
        ? CopyWith$Fragment$SizeTreeFragment.stub(_then(_instance))
        : CopyWith$Fragment$SizeTreeFragment(local$size, (e) => call(size: e));
  }

  CopyWith$Fragment$VariantFragment$colour<TRes> get colour {
    final local$colour = _instance.colour;
    return local$colour == null
        ? CopyWith$Fragment$VariantFragment$colour.stub(_then(_instance))
        : CopyWith$Fragment$VariantFragment$colour(
            local$colour,
            (e) => call(colour: e),
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

  CopyWith$Fragment$PriceFragment<TRes> get price {
    final local$price = _instance.price;
    return CopyWith$Fragment$PriceFragment(local$price, (e) => call(price: e));
  }
}

class _CopyWithStubImpl$Fragment$VariantFragment<TRes>
    implements CopyWith$Fragment$VariantFragment<TRes> {
  _CopyWithStubImpl$Fragment$VariantFragment(this._res);

  TRes _res;

  call({
    String? sku,
    Fragment$SizeTreeFragment? size,
    Fragment$VariantFragment$colour? colour,
    List<Fragment$AttributesFragment>? attributes,
    int? stock,
    Fragment$PriceFragment? price,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$SizeTreeFragment<TRes> get size =>
      CopyWith$Fragment$SizeTreeFragment.stub(_res);

  CopyWith$Fragment$VariantFragment$colour<TRes> get colour =>
      CopyWith$Fragment$VariantFragment$colour.stub(_res);

  attributes(_fn) => _res;

  CopyWith$Fragment$PriceFragment<TRes> get price =>
      CopyWith$Fragment$PriceFragment.stub(_res);
}

const fragmentDefinitionVariantFragment = FragmentDefinitionNode(
  name: NameNode(value: 'VariantFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Variant'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'sku'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'size'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'SizeTreeFragment'),
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
        name: NameNode(value: 'colour'),
        alias: null,
        arguments: [],
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
        name: NameNode(value: 'stock'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'price'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'PriceFragment'),
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
const documentNodeFragmentVariantFragment = DocumentNode(
  definitions: [
    fragmentDefinitionVariantFragment,
    fragmentDefinitionSizeTreeFragment,
    fragmentDefinitionSizeFragment,
    fragmentDefinitionSizeGuideTreeFragment,
    fragmentDefinitionSizeGuideFragment,
    fragmentDefinitionAttributesFragment,
    fragmentDefinitionPriceFragment,
    fragmentDefinitionMoneyFragment,
  ],
);

extension ClientExtension$Fragment$VariantFragment on graphql.GraphQLClient {
  void writeFragment$VariantFragment({
    required Fragment$VariantFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'VariantFragment',
        document: documentNodeFragmentVariantFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$VariantFragment? readFragment$VariantFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'VariantFragment',
          document: documentNodeFragmentVariantFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$VariantFragment.fromJson(result);
  }
}

class Fragment$VariantFragment$colour {
  Fragment$VariantFragment$colour({
    required this.id,
    this.$__typename = 'Colour',
  });

  factory Fragment$VariantFragment$colour.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Fragment$VariantFragment$colour(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$VariantFragment$colour ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Fragment$VariantFragment$colour
    on Fragment$VariantFragment$colour {
  CopyWith$Fragment$VariantFragment$colour<Fragment$VariantFragment$colour>
  get copyWith => CopyWith$Fragment$VariantFragment$colour(this, (i) => i);
}

abstract class CopyWith$Fragment$VariantFragment$colour<TRes> {
  factory CopyWith$Fragment$VariantFragment$colour(
    Fragment$VariantFragment$colour instance,
    TRes Function(Fragment$VariantFragment$colour) then,
  ) = _CopyWithImpl$Fragment$VariantFragment$colour;

  factory CopyWith$Fragment$VariantFragment$colour.stub(TRes res) =
      _CopyWithStubImpl$Fragment$VariantFragment$colour;

  TRes call({String? id, String? $__typename});
}

class _CopyWithImpl$Fragment$VariantFragment$colour<TRes>
    implements CopyWith$Fragment$VariantFragment$colour<TRes> {
  _CopyWithImpl$Fragment$VariantFragment$colour(this._instance, this._then);

  final Fragment$VariantFragment$colour _instance;

  final TRes Function(Fragment$VariantFragment$colour) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Fragment$VariantFragment$colour(
          id: id == _undefined || id == null ? _instance.id : (id as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Fragment$VariantFragment$colour<TRes>
    implements CopyWith$Fragment$VariantFragment$colour<TRes> {
  _CopyWithStubImpl$Fragment$VariantFragment$colour(this._res);

  TRes _res;

  call({String? id, String? $__typename}) => _res;
}
