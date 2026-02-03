import '../../../../schema.graphql.dart';
import '../brands/fragments/brand_fragment.graphql.dart';
import '../fragments/attributes_fragment.graphql.dart';
import '../fragments/colour_fragment.graphql.dart';
import '../fragments/media_fragment.graphql.dart';
import '../fragments/money_fragment.graphql.dart';
import '../fragments/price_fragment.graphql.dart';
import '../fragments/price_range_fragment.graphql.dart';
import '../fragments/size_fragment.graphql.dart';
import '../fragments/variant_fragment.graphql.dart';
import 'dart:async';
import 'fragments/pagination_fragment.graphql.dart';
import 'fragments/product_fragment.graphql.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$GetProduct {
  factory Variables$Query$GetProduct({required String productId}) =>
      Variables$Query$GetProduct._({r'productId': productId});

  Variables$Query$GetProduct._(this._$data);

  factory Variables$Query$GetProduct.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$productId = data['productId'];
    result$data['productId'] = (l$productId as String);
    return Variables$Query$GetProduct._(result$data);
  }

  Map<String, dynamic> _$data;

  String get productId => (_$data['productId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$productId = productId;
    result$data['productId'] = l$productId;
    return result$data;
  }

  CopyWith$Variables$Query$GetProduct<Variables$Query$GetProduct>
  get copyWith => CopyWith$Variables$Query$GetProduct(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetProduct ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productId = productId;
    final lOther$productId = other.productId;
    if (l$productId != lOther$productId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$productId = productId;
    return Object.hashAll([l$productId]);
  }
}

abstract class CopyWith$Variables$Query$GetProduct<TRes> {
  factory CopyWith$Variables$Query$GetProduct(
    Variables$Query$GetProduct instance,
    TRes Function(Variables$Query$GetProduct) then,
  ) = _CopyWithImpl$Variables$Query$GetProduct;

  factory CopyWith$Variables$Query$GetProduct.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetProduct;

  TRes call({String? productId});
}

class _CopyWithImpl$Variables$Query$GetProduct<TRes>
    implements CopyWith$Variables$Query$GetProduct<TRes> {
  _CopyWithImpl$Variables$Query$GetProduct(this._instance, this._then);

  final Variables$Query$GetProduct _instance;

  final TRes Function(Variables$Query$GetProduct) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? productId = _undefined}) => _then(
    Variables$Query$GetProduct._({
      ..._instance._$data,
      if (productId != _undefined && productId != null)
        'productId': (productId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetProduct<TRes>
    implements CopyWith$Variables$Query$GetProduct<TRes> {
  _CopyWithStubImpl$Variables$Query$GetProduct(this._res);

  TRes _res;

  call({String? productId}) => _res;
}

class Query$GetProduct {
  Query$GetProduct({this.product, this.$__typename = 'Query'});

  factory Query$GetProduct.fromJson(Map<String, dynamic> json) {
    final l$product = json['product'];
    final l$$__typename = json['__typename'];
    return Query$GetProduct(
      product: l$product == null
          ? null
          : Fragment$ProductFragment.fromJson(
              (l$product as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$ProductFragment? product;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$product = product;
    _resultData['product'] = l$product?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$product = product;
    final l$$__typename = $__typename;
    return Object.hashAll([l$product, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetProduct || runtimeType != other.runtimeType) {
      return false;
    }
    final l$product = product;
    final lOther$product = other.product;
    if (l$product != lOther$product) {
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

extension UtilityExtension$Query$GetProduct on Query$GetProduct {
  CopyWith$Query$GetProduct<Query$GetProduct> get copyWith =>
      CopyWith$Query$GetProduct(this, (i) => i);
}

abstract class CopyWith$Query$GetProduct<TRes> {
  factory CopyWith$Query$GetProduct(
    Query$GetProduct instance,
    TRes Function(Query$GetProduct) then,
  ) = _CopyWithImpl$Query$GetProduct;

  factory CopyWith$Query$GetProduct.stub(TRes res) =
      _CopyWithStubImpl$Query$GetProduct;

  TRes call({Fragment$ProductFragment? product, String? $__typename});
  CopyWith$Fragment$ProductFragment<TRes> get product;
}

class _CopyWithImpl$Query$GetProduct<TRes>
    implements CopyWith$Query$GetProduct<TRes> {
  _CopyWithImpl$Query$GetProduct(this._instance, this._then);

  final Query$GetProduct _instance;

  final TRes Function(Query$GetProduct) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? product = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetProduct(
          product: product == _undefined
              ? _instance.product
              : (product as Fragment$ProductFragment?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Fragment$ProductFragment<TRes> get product {
    final local$product = _instance.product;
    return local$product == null
        ? CopyWith$Fragment$ProductFragment.stub(_then(_instance))
        : CopyWith$Fragment$ProductFragment(
            local$product,
            (e) => call(product: e),
          );
  }
}

class _CopyWithStubImpl$Query$GetProduct<TRes>
    implements CopyWith$Query$GetProduct<TRes> {
  _CopyWithStubImpl$Query$GetProduct(this._res);

  TRes _res;

  call({Fragment$ProductFragment? product, String? $__typename}) => _res;

  CopyWith$Fragment$ProductFragment<TRes> get product =>
      CopyWith$Fragment$ProductFragment.stub(_res);
}

const documentNodeQueryGetProduct = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetProduct'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'productId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'product'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'productId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ProductFragment'),
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
    ),
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
Query$GetProduct _parserFn$Query$GetProduct(Map<String, dynamic> data) =>
    Query$GetProduct.fromJson(data);
typedef OnQueryComplete$Query$GetProduct =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetProduct?);

class Options$Query$GetProduct extends graphql.QueryOptions<Query$GetProduct> {
  Options$Query$GetProduct({
    String? operationName,
    required Variables$Query$GetProduct variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetProduct? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetProduct? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(
                 data,
                 data == null ? null : _parserFn$Query$GetProduct(data),
               ),
         onError: onError,
         document: documentNodeQueryGetProduct,
         parserFn: _parserFn$Query$GetProduct,
       );

  final OnQueryComplete$Query$GetProduct? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetProduct
    extends graphql.WatchQueryOptions<Query$GetProduct> {
  WatchOptions$Query$GetProduct({
    String? operationName,
    required Variables$Query$GetProduct variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetProduct? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGetProduct,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetProduct,
       );
}

class FetchMoreOptions$Query$GetProduct extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetProduct({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetProduct variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGetProduct,
       );
}

extension ClientExtension$Query$GetProduct on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetProduct>> query$GetProduct(
    Options$Query$GetProduct options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$GetProduct> watchQuery$GetProduct(
    WatchOptions$Query$GetProduct options,
  ) => this.watchQuery(options);

  void writeQuery$GetProduct({
    required Query$GetProduct data,
    required Variables$Query$GetProduct variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetProduct),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$GetProduct? readQuery$GetProduct({
    required Variables$Query$GetProduct variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetProduct),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetProduct.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetProduct> useQuery$GetProduct(
  Options$Query$GetProduct options,
) => graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetProduct> useWatchQuery$GetProduct(
  WatchOptions$Query$GetProduct options,
) => graphql_flutter.useWatchQuery(options);

class Query$GetProduct$Widget extends graphql_flutter.Query<Query$GetProduct> {
  Query$GetProduct$Widget({
    widgets.Key? key,
    required Options$Query$GetProduct options,
    required graphql_flutter.QueryBuilder<Query$GetProduct> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Variables$Query$ProductListingQuery {
  factory Variables$Query$ProductListingQuery({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    Enum$ProductListingSort? sort,
  }) => Variables$Query$ProductListingQuery._({
    r'offset': offset,
    r'limit': limit,
    if (categoryId != null) r'categoryId': categoryId,
    if (query != null) r'query': query,
    if (sort != null) r'sort': sort,
  });

  Variables$Query$ProductListingQuery._(this._$data);

  factory Variables$Query$ProductListingQuery.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$offset = data['offset'];
    result$data['offset'] = (l$offset as int);
    final l$limit = data['limit'];
    result$data['limit'] = (l$limit as int);
    if (data.containsKey('categoryId')) {
      final l$categoryId = data['categoryId'];
      result$data['categoryId'] = (l$categoryId as String?);
    }
    if (data.containsKey('query')) {
      final l$query = data['query'];
      result$data['query'] = (l$query as String?);
    }
    if (data.containsKey('sort')) {
      final l$sort = data['sort'];
      result$data['sort'] = l$sort == null
          ? null
          : fromJson$Enum$ProductListingSort((l$sort as String));
    }
    return Variables$Query$ProductListingQuery._(result$data);
  }

  Map<String, dynamic> _$data;

  int get offset => (_$data['offset'] as int);

  int get limit => (_$data['limit'] as int);

  String? get categoryId => (_$data['categoryId'] as String?);

  String? get query => (_$data['query'] as String?);

  Enum$ProductListingSort? get sort =>
      (_$data['sort'] as Enum$ProductListingSort?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$offset = offset;
    result$data['offset'] = l$offset;
    final l$limit = limit;
    result$data['limit'] = l$limit;
    if (_$data.containsKey('categoryId')) {
      final l$categoryId = categoryId;
      result$data['categoryId'] = l$categoryId;
    }
    if (_$data.containsKey('query')) {
      final l$query = query;
      result$data['query'] = l$query;
    }
    if (_$data.containsKey('sort')) {
      final l$sort = sort;
      result$data['sort'] = l$sort == null
          ? null
          : toJson$Enum$ProductListingSort(l$sort);
    }
    return result$data;
  }

  CopyWith$Variables$Query$ProductListingQuery<
    Variables$Query$ProductListingQuery
  >
  get copyWith => CopyWith$Variables$Query$ProductListingQuery(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$ProductListingQuery ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$offset = offset;
    final lOther$offset = other.offset;
    if (l$offset != lOther$offset) {
      return false;
    }
    final l$limit = limit;
    final lOther$limit = other.limit;
    if (l$limit != lOther$limit) {
      return false;
    }
    final l$categoryId = categoryId;
    final lOther$categoryId = other.categoryId;
    if (_$data.containsKey('categoryId') !=
        other._$data.containsKey('categoryId')) {
      return false;
    }
    if (l$categoryId != lOther$categoryId) {
      return false;
    }
    final l$query = query;
    final lOther$query = other.query;
    if (_$data.containsKey('query') != other._$data.containsKey('query')) {
      return false;
    }
    if (l$query != lOther$query) {
      return false;
    }
    final l$sort = sort;
    final lOther$sort = other.sort;
    if (_$data.containsKey('sort') != other._$data.containsKey('sort')) {
      return false;
    }
    if (l$sort != lOther$sort) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$offset = offset;
    final l$limit = limit;
    final l$categoryId = categoryId;
    final l$query = query;
    final l$sort = sort;
    return Object.hashAll([
      l$offset,
      l$limit,
      _$data.containsKey('categoryId') ? l$categoryId : const {},
      _$data.containsKey('query') ? l$query : const {},
      _$data.containsKey('sort') ? l$sort : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$ProductListingQuery<TRes> {
  factory CopyWith$Variables$Query$ProductListingQuery(
    Variables$Query$ProductListingQuery instance,
    TRes Function(Variables$Query$ProductListingQuery) then,
  ) = _CopyWithImpl$Variables$Query$ProductListingQuery;

  factory CopyWith$Variables$Query$ProductListingQuery.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$ProductListingQuery;

  TRes call({
    int? offset,
    int? limit,
    String? categoryId,
    String? query,
    Enum$ProductListingSort? sort,
  });
}

class _CopyWithImpl$Variables$Query$ProductListingQuery<TRes>
    implements CopyWith$Variables$Query$ProductListingQuery<TRes> {
  _CopyWithImpl$Variables$Query$ProductListingQuery(this._instance, this._then);

  final Variables$Query$ProductListingQuery _instance;

  final TRes Function(Variables$Query$ProductListingQuery) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? offset = _undefined,
    Object? limit = _undefined,
    Object? categoryId = _undefined,
    Object? query = _undefined,
    Object? sort = _undefined,
  }) => _then(
    Variables$Query$ProductListingQuery._({
      ..._instance._$data,
      if (offset != _undefined && offset != null) 'offset': (offset as int),
      if (limit != _undefined && limit != null) 'limit': (limit as int),
      if (categoryId != _undefined) 'categoryId': (categoryId as String?),
      if (query != _undefined) 'query': (query as String?),
      if (sort != _undefined) 'sort': (sort as Enum$ProductListingSort?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$ProductListingQuery<TRes>
    implements CopyWith$Variables$Query$ProductListingQuery<TRes> {
  _CopyWithStubImpl$Variables$Query$ProductListingQuery(this._res);

  TRes _res;

  call({
    int? offset,
    int? limit,
    String? categoryId,
    String? query,
    Enum$ProductListingSort? sort,
  }) => _res;
}

class Query$ProductListingQuery {
  Query$ProductListingQuery({this.productListing, this.$__typename = 'Query'});

  factory Query$ProductListingQuery.fromJson(Map<String, dynamic> json) {
    final l$productListing = json['productListing'];
    final l$$__typename = json['__typename'];
    return Query$ProductListingQuery(
      productListing: l$productListing == null
          ? null
          : Query$ProductListingQuery$productListing.fromJson(
              (l$productListing as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$ProductListingQuery$productListing? productListing;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$productListing = productListing;
    _resultData['productListing'] = l$productListing?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$productListing = productListing;
    final l$$__typename = $__typename;
    return Object.hashAll([l$productListing, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$ProductListingQuery ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productListing = productListing;
    final lOther$productListing = other.productListing;
    if (l$productListing != lOther$productListing) {
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

extension UtilityExtension$Query$ProductListingQuery
    on Query$ProductListingQuery {
  CopyWith$Query$ProductListingQuery<Query$ProductListingQuery> get copyWith =>
      CopyWith$Query$ProductListingQuery(this, (i) => i);
}

abstract class CopyWith$Query$ProductListingQuery<TRes> {
  factory CopyWith$Query$ProductListingQuery(
    Query$ProductListingQuery instance,
    TRes Function(Query$ProductListingQuery) then,
  ) = _CopyWithImpl$Query$ProductListingQuery;

  factory CopyWith$Query$ProductListingQuery.stub(TRes res) =
      _CopyWithStubImpl$Query$ProductListingQuery;

  TRes call({
    Query$ProductListingQuery$productListing? productListing,
    String? $__typename,
  });
  CopyWith$Query$ProductListingQuery$productListing<TRes> get productListing;
}

class _CopyWithImpl$Query$ProductListingQuery<TRes>
    implements CopyWith$Query$ProductListingQuery<TRes> {
  _CopyWithImpl$Query$ProductListingQuery(this._instance, this._then);

  final Query$ProductListingQuery _instance;

  final TRes Function(Query$ProductListingQuery) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? productListing = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$ProductListingQuery(
      productListing: productListing == _undefined
          ? _instance.productListing
          : (productListing as Query$ProductListingQuery$productListing?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$ProductListingQuery$productListing<TRes> get productListing {
    final local$productListing = _instance.productListing;
    return local$productListing == null
        ? CopyWith$Query$ProductListingQuery$productListing.stub(
            _then(_instance),
          )
        : CopyWith$Query$ProductListingQuery$productListing(
            local$productListing,
            (e) => call(productListing: e),
          );
  }
}

class _CopyWithStubImpl$Query$ProductListingQuery<TRes>
    implements CopyWith$Query$ProductListingQuery<TRes> {
  _CopyWithStubImpl$Query$ProductListingQuery(this._res);

  TRes _res;

  call({
    Query$ProductListingQuery$productListing? productListing,
    String? $__typename,
  }) => _res;

  CopyWith$Query$ProductListingQuery$productListing<TRes> get productListing =>
      CopyWith$Query$ProductListingQuery$productListing.stub(_res);
}

const documentNodeQueryProductListingQuery = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ProductListingQuery'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'offset')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'limit')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'categoryId')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'query')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'sort')),
          type: NamedTypeNode(
            name: NameNode(value: 'ProductListingSort'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'productListing'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'offset'),
                value: VariableNode(name: NameNode(value: 'offset')),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: VariableNode(name: NameNode(value: 'limit')),
              ),
              ArgumentNode(
                name: NameNode(value: 'categoryId'),
                value: VariableNode(name: NameNode(value: 'categoryId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'query'),
                value: VariableNode(name: NameNode(value: 'query')),
              ),
              ArgumentNode(
                name: NameNode(value: 'sort'),
                value: VariableNode(name: NameNode(value: 'sort')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'pagination'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'PaginationFragment'),
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
                  name: NameNode(value: 'products'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'ProductFragment'),
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
    fragmentDefinitionPaginationFragment,
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
Query$ProductListingQuery _parserFn$Query$ProductListingQuery(
  Map<String, dynamic> data,
) => Query$ProductListingQuery.fromJson(data);
typedef OnQueryComplete$Query$ProductListingQuery =
    FutureOr<void> Function(Map<String, dynamic>?, Query$ProductListingQuery?);

class Options$Query$ProductListingQuery
    extends graphql.QueryOptions<Query$ProductListingQuery> {
  Options$Query$ProductListingQuery({
    String? operationName,
    required Variables$Query$ProductListingQuery variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$ProductListingQuery? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$ProductListingQuery? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(
                 data,
                 data == null
                     ? null
                     : _parserFn$Query$ProductListingQuery(data),
               ),
         onError: onError,
         document: documentNodeQueryProductListingQuery,
         parserFn: _parserFn$Query$ProductListingQuery,
       );

  final OnQueryComplete$Query$ProductListingQuery? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$ProductListingQuery
    extends graphql.WatchQueryOptions<Query$ProductListingQuery> {
  WatchOptions$Query$ProductListingQuery({
    String? operationName,
    required Variables$Query$ProductListingQuery variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$ProductListingQuery? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryProductListingQuery,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$ProductListingQuery,
       );
}

class FetchMoreOptions$Query$ProductListingQuery
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$ProductListingQuery({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$ProductListingQuery variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryProductListingQuery,
       );
}

extension ClientExtension$Query$ProductListingQuery on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$ProductListingQuery>>
  query$ProductListingQuery(Options$Query$ProductListingQuery options) async =>
      await this.query(options);

  graphql.ObservableQuery<Query$ProductListingQuery>
  watchQuery$ProductListingQuery(
    WatchOptions$Query$ProductListingQuery options,
  ) => this.watchQuery(options);

  void writeQuery$ProductListingQuery({
    required Query$ProductListingQuery data,
    required Variables$Query$ProductListingQuery variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(
        document: documentNodeQueryProductListingQuery,
      ),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$ProductListingQuery? readQuery$ProductListingQuery({
    required Variables$Query$ProductListingQuery variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQueryProductListingQuery,
        ),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$ProductListingQuery.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$ProductListingQuery>
useQuery$ProductListingQuery(Options$Query$ProductListingQuery options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$ProductListingQuery>
useWatchQuery$ProductListingQuery(
  WatchOptions$Query$ProductListingQuery options,
) => graphql_flutter.useWatchQuery(options);

class Query$ProductListingQuery$Widget
    extends graphql_flutter.Query<Query$ProductListingQuery> {
  Query$ProductListingQuery$Widget({
    widgets.Key? key,
    required Options$Query$ProductListingQuery options,
    required graphql_flutter.QueryBuilder<Query$ProductListingQuery> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Query$ProductListingQuery$productListing {
  Query$ProductListingQuery$productListing({
    required this.title,
    required this.pagination,
    required this.products,
    this.$__typename = 'ProductListing',
  });

  factory Query$ProductListingQuery$productListing.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$title = json['title'];
    final l$pagination = json['pagination'];
    final l$products = json['products'];
    final l$$__typename = json['__typename'];
    return Query$ProductListingQuery$productListing(
      title: (l$title as String),
      pagination: Fragment$PaginationFragment.fromJson(
        (l$pagination as Map<String, dynamic>),
      ),
      products: (l$products as List<dynamic>)
          .map(
            (e) =>
                Fragment$ProductFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String title;

  final Fragment$PaginationFragment pagination;

  final List<Fragment$ProductFragment> products;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$title = title;
    _resultData['title'] = l$title;
    final l$pagination = pagination;
    _resultData['pagination'] = l$pagination.toJson();
    final l$products = products;
    _resultData['products'] = l$products.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$pagination = pagination;
    final l$products = products;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$title,
      l$pagination,
      Object.hashAll(l$products.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$ProductListingQuery$productListing ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$pagination = pagination;
    final lOther$pagination = other.pagination;
    if (l$pagination != lOther$pagination) {
      return false;
    }
    final l$products = products;
    final lOther$products = other.products;
    if (l$products.length != lOther$products.length) {
      return false;
    }
    for (int i = 0; i < l$products.length; i++) {
      final l$products$entry = l$products[i];
      final lOther$products$entry = lOther$products[i];
      if (l$products$entry != lOther$products$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ProductListingQuery$productListing
    on Query$ProductListingQuery$productListing {
  CopyWith$Query$ProductListingQuery$productListing<
    Query$ProductListingQuery$productListing
  >
  get copyWith =>
      CopyWith$Query$ProductListingQuery$productListing(this, (i) => i);
}

abstract class CopyWith$Query$ProductListingQuery$productListing<TRes> {
  factory CopyWith$Query$ProductListingQuery$productListing(
    Query$ProductListingQuery$productListing instance,
    TRes Function(Query$ProductListingQuery$productListing) then,
  ) = _CopyWithImpl$Query$ProductListingQuery$productListing;

  factory CopyWith$Query$ProductListingQuery$productListing.stub(TRes res) =
      _CopyWithStubImpl$Query$ProductListingQuery$productListing;

  TRes call({
    String? title,
    Fragment$PaginationFragment? pagination,
    List<Fragment$ProductFragment>? products,
    String? $__typename,
  });
  CopyWith$Fragment$PaginationFragment<TRes> get pagination;
  TRes products(
    Iterable<Fragment$ProductFragment> Function(
      Iterable<CopyWith$Fragment$ProductFragment<Fragment$ProductFragment>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$ProductListingQuery$productListing<TRes>
    implements CopyWith$Query$ProductListingQuery$productListing<TRes> {
  _CopyWithImpl$Query$ProductListingQuery$productListing(
    this._instance,
    this._then,
  );

  final Query$ProductListingQuery$productListing _instance;

  final TRes Function(Query$ProductListingQuery$productListing) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? pagination = _undefined,
    Object? products = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$ProductListingQuery$productListing(
      title: title == _undefined || title == null
          ? _instance.title
          : (title as String),
      pagination: pagination == _undefined || pagination == null
          ? _instance.pagination
          : (pagination as Fragment$PaginationFragment),
      products: products == _undefined || products == null
          ? _instance.products
          : (products as List<Fragment$ProductFragment>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$PaginationFragment<TRes> get pagination {
    final local$pagination = _instance.pagination;
    return CopyWith$Fragment$PaginationFragment(
      local$pagination,
      (e) => call(pagination: e),
    );
  }

  TRes products(
    Iterable<Fragment$ProductFragment> Function(
      Iterable<CopyWith$Fragment$ProductFragment<Fragment$ProductFragment>>,
    )
    _fn,
  ) => call(
    products: _fn(
      _instance.products.map(
        (e) => CopyWith$Fragment$ProductFragment(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$ProductListingQuery$productListing<TRes>
    implements CopyWith$Query$ProductListingQuery$productListing<TRes> {
  _CopyWithStubImpl$Query$ProductListingQuery$productListing(this._res);

  TRes _res;

  call({
    String? title,
    Fragment$PaginationFragment? pagination,
    List<Fragment$ProductFragment>? products,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$PaginationFragment<TRes> get pagination =>
      CopyWith$Fragment$PaginationFragment.stub(_res);

  products(_fn) => _res;
}
