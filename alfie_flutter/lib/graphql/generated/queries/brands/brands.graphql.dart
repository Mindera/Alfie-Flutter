import 'dart:async';
import 'fragments/brand_fragment.graphql.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Query$Brands {
  Query$Brands({required this.brands, this.$__typename = 'Query'});

  factory Query$Brands.fromJson(Map<String, dynamic> json) {
    final l$brands = json['brands'];
    final l$$__typename = json['__typename'];
    return Query$Brands(
      brands: (l$brands as List<dynamic>)
          .map(
            (e) => Fragment$BrandFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$BrandFragment> brands;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$brands = brands;
    _resultData['brands'] = l$brands.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$brands = brands;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$brands.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Brands || runtimeType != other.runtimeType) {
      return false;
    }
    final l$brands = brands;
    final lOther$brands = other.brands;
    if (l$brands.length != lOther$brands.length) {
      return false;
    }
    for (int i = 0; i < l$brands.length; i++) {
      final l$brands$entry = l$brands[i];
      final lOther$brands$entry = lOther$brands[i];
      if (l$brands$entry != lOther$brands$entry) {
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

extension UtilityExtension$Query$Brands on Query$Brands {
  CopyWith$Query$Brands<Query$Brands> get copyWith =>
      CopyWith$Query$Brands(this, (i) => i);
}

abstract class CopyWith$Query$Brands<TRes> {
  factory CopyWith$Query$Brands(
    Query$Brands instance,
    TRes Function(Query$Brands) then,
  ) = _CopyWithImpl$Query$Brands;

  factory CopyWith$Query$Brands.stub(TRes res) = _CopyWithStubImpl$Query$Brands;

  TRes call({List<Fragment$BrandFragment>? brands, String? $__typename});
  TRes brands(
    Iterable<Fragment$BrandFragment> Function(
      Iterable<CopyWith$Fragment$BrandFragment<Fragment$BrandFragment>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$Brands<TRes> implements CopyWith$Query$Brands<TRes> {
  _CopyWithImpl$Query$Brands(this._instance, this._then);

  final Query$Brands _instance;

  final TRes Function(Query$Brands) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? brands = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$Brands(
          brands: brands == _undefined || brands == null
              ? _instance.brands
              : (brands as List<Fragment$BrandFragment>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  TRes brands(
    Iterable<Fragment$BrandFragment> Function(
      Iterable<CopyWith$Fragment$BrandFragment<Fragment$BrandFragment>>,
    )
    _fn,
  ) => call(
    brands: _fn(
      _instance.brands.map((e) => CopyWith$Fragment$BrandFragment(e, (i) => i)),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$Brands<TRes>
    implements CopyWith$Query$Brands<TRes> {
  _CopyWithStubImpl$Query$Brands(this._res);

  TRes _res;

  call({List<Fragment$BrandFragment>? brands, String? $__typename}) => _res;

  brands(_fn) => _res;
}

const documentNodeQueryBrands = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Brands'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'brands'),
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
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionBrandFragment,
  ],
);
Query$Brands _parserFn$Query$Brands(Map<String, dynamic> data) =>
    Query$Brands.fromJson(data);
typedef OnQueryComplete$Query$Brands =
    FutureOr<void> Function(Map<String, dynamic>?, Query$Brands?);

class Options$Query$Brands extends graphql.QueryOptions<Query$Brands> {
  Options$Query$Brands({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Brands? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Brands? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
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
                 data == null ? null : _parserFn$Query$Brands(data),
               ),
         onError: onError,
         document: documentNodeQueryBrands,
         parserFn: _parserFn$Query$Brands,
       );

  final OnQueryComplete$Query$Brands? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$Brands
    extends graphql.WatchQueryOptions<Query$Brands> {
  WatchOptions$Query$Brands({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Brands? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryBrands,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$Brands,
       );
}

class FetchMoreOptions$Query$Brands extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Brands({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryBrands);
}

extension ClientExtension$Query$Brands on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Brands>> query$Brands([
    Options$Query$Brands? options,
  ]) async => await this.query(options ?? Options$Query$Brands());

  graphql.ObservableQuery<Query$Brands> watchQuery$Brands([
    WatchOptions$Query$Brands? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$Brands());

  void writeQuery$Brands({required Query$Brands data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryBrands),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );

  Query$Brands? readQuery$Brands({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryBrands),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Brands.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$Brands> useQuery$Brands([
  Options$Query$Brands? options,
]) => graphql_flutter.useQuery(options ?? Options$Query$Brands());
graphql.ObservableQuery<Query$Brands> useWatchQuery$Brands([
  WatchOptions$Query$Brands? options,
]) => graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$Brands());

class Query$Brands$Widget extends graphql_flutter.Query<Query$Brands> {
  Query$Brands$Widget({
    widgets.Key? key,
    Options$Query$Brands? options,
    required graphql_flutter.QueryBuilder<Query$Brands> builder,
  }) : super(
         key: key,
         options: options ?? Options$Query$Brands(),
         builder: builder,
       );
}
