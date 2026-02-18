import '../../fragments/image_fragment.graphql.dart';
import '../../fragments/media_fragment.graphql.dart';
import '../../fragments/money_fragment.graphql.dart';
import '../../fragments/price_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$SuggestionProductFragment {
  Fragment$SuggestionProductFragment({
    required this.id,
    required this.name,
    required this.brandName,
    required this.media,
    required this.price,
    required this.slug,
    this.$__typename = 'SuggestionProduct',
  });

  factory Fragment$SuggestionProductFragment.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$brandName = json['brandName'];
    final l$media = json['media'];
    final l$price = json['price'];
    final l$slug = json['slug'];
    final l$$__typename = json['__typename'];
    return Fragment$SuggestionProductFragment(
      id: (l$id as String),
      name: (l$name as String),
      brandName: (l$brandName as String),
      media: (l$media as List<dynamic>)
          .map(
            (e) => Fragment$MediaFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      price: Fragment$PriceFragment.fromJson((l$price as Map<String, dynamic>)),
      slug: (l$slug as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String brandName;

  final List<Fragment$MediaFragment> media;

  final Fragment$PriceFragment price;

  final String slug;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$brandName = brandName;
    _resultData['brandName'] = l$brandName;
    final l$media = media;
    _resultData['media'] = l$media.map((e) => e.toJson()).toList();
    final l$price = price;
    _resultData['price'] = l$price.toJson();
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$brandName = brandName;
    final l$media = media;
    final l$price = price;
    final l$slug = slug;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$brandName,
      Object.hashAll(l$media.map((v) => v)),
      l$price,
      l$slug,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SuggestionProductFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$brandName = brandName;
    final lOther$brandName = other.brandName;
    if (l$brandName != lOther$brandName) {
      return false;
    }
    final l$media = media;
    final lOther$media = other.media;
    if (l$media.length != lOther$media.length) {
      return false;
    }
    for (int i = 0; i < l$media.length; i++) {
      final l$media$entry = l$media[i];
      final lOther$media$entry = lOther$media[i];
      if (l$media$entry != lOther$media$entry) {
        return false;
      }
    }
    final l$price = price;
    final lOther$price = other.price;
    if (l$price != lOther$price) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
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

extension UtilityExtension$Fragment$SuggestionProductFragment
    on Fragment$SuggestionProductFragment {
  CopyWith$Fragment$SuggestionProductFragment<
    Fragment$SuggestionProductFragment
  >
  get copyWith => CopyWith$Fragment$SuggestionProductFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SuggestionProductFragment<TRes> {
  factory CopyWith$Fragment$SuggestionProductFragment(
    Fragment$SuggestionProductFragment instance,
    TRes Function(Fragment$SuggestionProductFragment) then,
  ) = _CopyWithImpl$Fragment$SuggestionProductFragment;

  factory CopyWith$Fragment$SuggestionProductFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SuggestionProductFragment;

  TRes call({
    String? id,
    String? name,
    String? brandName,
    List<Fragment$MediaFragment>? media,
    Fragment$PriceFragment? price,
    String? slug,
    String? $__typename,
  });
  TRes media(
    Iterable<Fragment$MediaFragment> Function(
      Iterable<CopyWith$Fragment$MediaFragment<Fragment$MediaFragment>>,
    )
    _fn,
  );
  CopyWith$Fragment$PriceFragment<TRes> get price;
}

class _CopyWithImpl$Fragment$SuggestionProductFragment<TRes>
    implements CopyWith$Fragment$SuggestionProductFragment<TRes> {
  _CopyWithImpl$Fragment$SuggestionProductFragment(this._instance, this._then);

  final Fragment$SuggestionProductFragment _instance;

  final TRes Function(Fragment$SuggestionProductFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? brandName = _undefined,
    Object? media = _undefined,
    Object? price = _undefined,
    Object? slug = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$SuggestionProductFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      brandName: brandName == _undefined || brandName == null
          ? _instance.brandName
          : (brandName as String),
      media: media == _undefined || media == null
          ? _instance.media
          : (media as List<Fragment$MediaFragment>),
      price: price == _undefined || price == null
          ? _instance.price
          : (price as Fragment$PriceFragment),
      slug: slug == _undefined || slug == null
          ? _instance.slug
          : (slug as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes media(
    Iterable<Fragment$MediaFragment> Function(
      Iterable<CopyWith$Fragment$MediaFragment<Fragment$MediaFragment>>,
    )
    _fn,
  ) => call(
    media: _fn(
      _instance.media.map((e) => CopyWith$Fragment$MediaFragment(e, (i) => i)),
    ).toList(),
  );

  CopyWith$Fragment$PriceFragment<TRes> get price {
    final local$price = _instance.price;
    return CopyWith$Fragment$PriceFragment(local$price, (e) => call(price: e));
  }
}

class _CopyWithStubImpl$Fragment$SuggestionProductFragment<TRes>
    implements CopyWith$Fragment$SuggestionProductFragment<TRes> {
  _CopyWithStubImpl$Fragment$SuggestionProductFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? brandName,
    List<Fragment$MediaFragment>? media,
    Fragment$PriceFragment? price,
    String? slug,
    String? $__typename,
  }) => _res;

  media(_fn) => _res;

  CopyWith$Fragment$PriceFragment<TRes> get price =>
      CopyWith$Fragment$PriceFragment.stub(_res);
}

const fragmentDefinitionSuggestionProductFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SuggestionProductFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'SuggestionProduct'),
      isNonNull: false,
    ),
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
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'brandName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'media'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'MediaFragment'),
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
        name: NameNode(value: 'slug'),
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
);
const documentNodeFragmentSuggestionProductFragment = DocumentNode(
  definitions: [
    fragmentDefinitionSuggestionProductFragment,
    fragmentDefinitionMediaFragment,
    fragmentDefinitionImageFragment,
    fragmentDefinitionPriceFragment,
    fragmentDefinitionMoneyFragment,
  ],
);

extension ClientExtension$Fragment$SuggestionProductFragment
    on graphql.GraphQLClient {
  void writeFragment$SuggestionProductFragment({
    required Fragment$SuggestionProductFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SuggestionProductFragment',
        document: documentNodeFragmentSuggestionProductFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SuggestionProductFragment? readFragment$SuggestionProductFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SuggestionProductFragment',
          document: documentNodeFragmentSuggestionProductFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$SuggestionProductFragment.fromJson(result);
  }
}
