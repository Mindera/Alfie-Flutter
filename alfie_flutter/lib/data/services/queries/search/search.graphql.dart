import '../fragments/media_fragment.graphql.dart';
import '../fragments/money_fragment.graphql.dart';
import '../fragments/price_fragment.graphql.dart';
import 'dart:async';
import 'fragments/suggestion_brand_fragment.graphql.dart';
import 'fragments/suggestion_keyword_fragment.graphql.dart';
import 'fragments/suggestion_product_fragment.graphql.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$GetSuggestions {
  factory Variables$Query$GetSuggestions({required String term}) =>
      Variables$Query$GetSuggestions._({r'term': term});

  Variables$Query$GetSuggestions._(this._$data);

  factory Variables$Query$GetSuggestions.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$term = data['term'];
    result$data['term'] = (l$term as String);
    return Variables$Query$GetSuggestions._(result$data);
  }

  Map<String, dynamic> _$data;

  String get term => (_$data['term'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$term = term;
    result$data['term'] = l$term;
    return result$data;
  }

  CopyWith$Variables$Query$GetSuggestions<Variables$Query$GetSuggestions>
  get copyWith => CopyWith$Variables$Query$GetSuggestions(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetSuggestions ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$term = term;
    final lOther$term = other.term;
    if (l$term != lOther$term) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$term = term;
    return Object.hashAll([l$term]);
  }
}

abstract class CopyWith$Variables$Query$GetSuggestions<TRes> {
  factory CopyWith$Variables$Query$GetSuggestions(
    Variables$Query$GetSuggestions instance,
    TRes Function(Variables$Query$GetSuggestions) then,
  ) = _CopyWithImpl$Variables$Query$GetSuggestions;

  factory CopyWith$Variables$Query$GetSuggestions.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetSuggestions;

  TRes call({String? term});
}

class _CopyWithImpl$Variables$Query$GetSuggestions<TRes>
    implements CopyWith$Variables$Query$GetSuggestions<TRes> {
  _CopyWithImpl$Variables$Query$GetSuggestions(this._instance, this._then);

  final Variables$Query$GetSuggestions _instance;

  final TRes Function(Variables$Query$GetSuggestions) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? term = _undefined}) => _then(
    Variables$Query$GetSuggestions._({
      ..._instance._$data,
      if (term != _undefined && term != null) 'term': (term as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetSuggestions<TRes>
    implements CopyWith$Variables$Query$GetSuggestions<TRes> {
  _CopyWithStubImpl$Variables$Query$GetSuggestions(this._res);

  TRes _res;

  call({String? term}) => _res;
}

class Query$GetSuggestions {
  Query$GetSuggestions({required this.suggestion, this.$__typename = 'Query'});

  factory Query$GetSuggestions.fromJson(Map<String, dynamic> json) {
    final l$suggestion = json['suggestion'];
    final l$$__typename = json['__typename'];
    return Query$GetSuggestions(
      suggestion: Query$GetSuggestions$suggestion.fromJson(
        (l$suggestion as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetSuggestions$suggestion suggestion;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$suggestion = suggestion;
    _resultData['suggestion'] = l$suggestion.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$suggestion = suggestion;
    final l$$__typename = $__typename;
    return Object.hashAll([l$suggestion, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetSuggestions || runtimeType != other.runtimeType) {
      return false;
    }
    final l$suggestion = suggestion;
    final lOther$suggestion = other.suggestion;
    if (l$suggestion != lOther$suggestion) {
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

extension UtilityExtension$Query$GetSuggestions on Query$GetSuggestions {
  CopyWith$Query$GetSuggestions<Query$GetSuggestions> get copyWith =>
      CopyWith$Query$GetSuggestions(this, (i) => i);
}

abstract class CopyWith$Query$GetSuggestions<TRes> {
  factory CopyWith$Query$GetSuggestions(
    Query$GetSuggestions instance,
    TRes Function(Query$GetSuggestions) then,
  ) = _CopyWithImpl$Query$GetSuggestions;

  factory CopyWith$Query$GetSuggestions.stub(TRes res) =
      _CopyWithStubImpl$Query$GetSuggestions;

  TRes call({Query$GetSuggestions$suggestion? suggestion, String? $__typename});
  CopyWith$Query$GetSuggestions$suggestion<TRes> get suggestion;
}

class _CopyWithImpl$Query$GetSuggestions<TRes>
    implements CopyWith$Query$GetSuggestions<TRes> {
  _CopyWithImpl$Query$GetSuggestions(this._instance, this._then);

  final Query$GetSuggestions _instance;

  final TRes Function(Query$GetSuggestions) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? suggestion = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetSuggestions(
      suggestion: suggestion == _undefined || suggestion == null
          ? _instance.suggestion
          : (suggestion as Query$GetSuggestions$suggestion),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$GetSuggestions$suggestion<TRes> get suggestion {
    final local$suggestion = _instance.suggestion;
    return CopyWith$Query$GetSuggestions$suggestion(
      local$suggestion,
      (e) => call(suggestion: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetSuggestions<TRes>
    implements CopyWith$Query$GetSuggestions<TRes> {
  _CopyWithStubImpl$Query$GetSuggestions(this._res);

  TRes _res;

  call({Query$GetSuggestions$suggestion? suggestion, String? $__typename}) =>
      _res;

  CopyWith$Query$GetSuggestions$suggestion<TRes> get suggestion =>
      CopyWith$Query$GetSuggestions$suggestion.stub(_res);
}

const documentNodeQueryGetSuggestions = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetSuggestions'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'term')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'suggestion'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'query'),
                value: VariableNode(name: NameNode(value: 'term')),
              ),
            ],
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
                        name: NameNode(value: 'SuggestionBrandFragment'),
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
                  name: NameNode(value: 'keywords'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'SuggestionKeywordFragment'),
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
                        name: NameNode(value: 'SuggestionProductFragment'),
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
    fragmentDefinitionSuggestionBrandFragment,
    fragmentDefinitionSuggestionKeywordFragment,
    fragmentDefinitionSuggestionProductFragment,
    fragmentDefinitionMediaFragment,
    fragmentDefinitionImageFragment,
    fragmentDefinitionPriceFragment,
    fragmentDefinitionMoneyFragment,
  ],
);
Query$GetSuggestions _parserFn$Query$GetSuggestions(
  Map<String, dynamic> data,
) => Query$GetSuggestions.fromJson(data);
typedef OnQueryComplete$Query$GetSuggestions =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetSuggestions?);

class Options$Query$GetSuggestions
    extends graphql.QueryOptions<Query$GetSuggestions> {
  Options$Query$GetSuggestions({
    String? operationName,
    required Variables$Query$GetSuggestions variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetSuggestions? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetSuggestions? onComplete,
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
                 data == null ? null : _parserFn$Query$GetSuggestions(data),
               ),
         onError: onError,
         document: documentNodeQueryGetSuggestions,
         parserFn: _parserFn$Query$GetSuggestions,
       );

  final OnQueryComplete$Query$GetSuggestions? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetSuggestions
    extends graphql.WatchQueryOptions<Query$GetSuggestions> {
  WatchOptions$Query$GetSuggestions({
    String? operationName,
    required Variables$Query$GetSuggestions variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetSuggestions? typedOptimisticResult,
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
         document: documentNodeQueryGetSuggestions,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetSuggestions,
       );
}

class FetchMoreOptions$Query$GetSuggestions extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetSuggestions({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetSuggestions variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGetSuggestions,
       );
}

extension ClientExtension$Query$GetSuggestions on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetSuggestions>> query$GetSuggestions(
    Options$Query$GetSuggestions options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$GetSuggestions> watchQuery$GetSuggestions(
    WatchOptions$Query$GetSuggestions options,
  ) => this.watchQuery(options);

  void writeQuery$GetSuggestions({
    required Query$GetSuggestions data,
    required Variables$Query$GetSuggestions variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetSuggestions),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$GetSuggestions? readQuery$GetSuggestions({
    required Variables$Query$GetSuggestions variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetSuggestions),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetSuggestions.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetSuggestions> useQuery$GetSuggestions(
  Options$Query$GetSuggestions options,
) => graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetSuggestions> useWatchQuery$GetSuggestions(
  WatchOptions$Query$GetSuggestions options,
) => graphql_flutter.useWatchQuery(options);

class Query$GetSuggestions$Widget
    extends graphql_flutter.Query<Query$GetSuggestions> {
  Query$GetSuggestions$Widget({
    widgets.Key? key,
    required Options$Query$GetSuggestions options,
    required graphql_flutter.QueryBuilder<Query$GetSuggestions> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Query$GetSuggestions$suggestion {
  Query$GetSuggestions$suggestion({
    required this.brands,
    required this.keywords,
    required this.products,
    this.$__typename = 'Suggestion',
  });

  factory Query$GetSuggestions$suggestion.fromJson(Map<String, dynamic> json) {
    final l$brands = json['brands'];
    final l$keywords = json['keywords'];
    final l$products = json['products'];
    final l$$__typename = json['__typename'];
    return Query$GetSuggestions$suggestion(
      brands: (l$brands as List<dynamic>)
          .map(
            (e) => Fragment$SuggestionBrandFragment.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      keywords: (l$keywords as List<dynamic>)
          .map(
            (e) => Fragment$SuggestionKeywordFragment.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      products: (l$products as List<dynamic>)
          .map(
            (e) => Fragment$SuggestionProductFragment.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$SuggestionBrandFragment> brands;

  final List<Fragment$SuggestionKeywordFragment> keywords;

  final List<Fragment$SuggestionProductFragment> products;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$brands = brands;
    _resultData['brands'] = l$brands.map((e) => e.toJson()).toList();
    final l$keywords = keywords;
    _resultData['keywords'] = l$keywords.map((e) => e.toJson()).toList();
    final l$products = products;
    _resultData['products'] = l$products.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$brands = brands;
    final l$keywords = keywords;
    final l$products = products;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$brands.map((v) => v)),
      Object.hashAll(l$keywords.map((v) => v)),
      Object.hashAll(l$products.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetSuggestions$suggestion ||
        runtimeType != other.runtimeType) {
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
    final l$keywords = keywords;
    final lOther$keywords = other.keywords;
    if (l$keywords.length != lOther$keywords.length) {
      return false;
    }
    for (int i = 0; i < l$keywords.length; i++) {
      final l$keywords$entry = l$keywords[i];
      final lOther$keywords$entry = lOther$keywords[i];
      if (l$keywords$entry != lOther$keywords$entry) {
        return false;
      }
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

extension UtilityExtension$Query$GetSuggestions$suggestion
    on Query$GetSuggestions$suggestion {
  CopyWith$Query$GetSuggestions$suggestion<Query$GetSuggestions$suggestion>
  get copyWith => CopyWith$Query$GetSuggestions$suggestion(this, (i) => i);
}

abstract class CopyWith$Query$GetSuggestions$suggestion<TRes> {
  factory CopyWith$Query$GetSuggestions$suggestion(
    Query$GetSuggestions$suggestion instance,
    TRes Function(Query$GetSuggestions$suggestion) then,
  ) = _CopyWithImpl$Query$GetSuggestions$suggestion;

  factory CopyWith$Query$GetSuggestions$suggestion.stub(TRes res) =
      _CopyWithStubImpl$Query$GetSuggestions$suggestion;

  TRes call({
    List<Fragment$SuggestionBrandFragment>? brands,
    List<Fragment$SuggestionKeywordFragment>? keywords,
    List<Fragment$SuggestionProductFragment>? products,
    String? $__typename,
  });
  TRes brands(
    Iterable<Fragment$SuggestionBrandFragment> Function(
      Iterable<
        CopyWith$Fragment$SuggestionBrandFragment<
          Fragment$SuggestionBrandFragment
        >
      >,
    )
    _fn,
  );
  TRes keywords(
    Iterable<Fragment$SuggestionKeywordFragment> Function(
      Iterable<
        CopyWith$Fragment$SuggestionKeywordFragment<
          Fragment$SuggestionKeywordFragment
        >
      >,
    )
    _fn,
  );
  TRes products(
    Iterable<Fragment$SuggestionProductFragment> Function(
      Iterable<
        CopyWith$Fragment$SuggestionProductFragment<
          Fragment$SuggestionProductFragment
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetSuggestions$suggestion<TRes>
    implements CopyWith$Query$GetSuggestions$suggestion<TRes> {
  _CopyWithImpl$Query$GetSuggestions$suggestion(this._instance, this._then);

  final Query$GetSuggestions$suggestion _instance;

  final TRes Function(Query$GetSuggestions$suggestion) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? brands = _undefined,
    Object? keywords = _undefined,
    Object? products = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetSuggestions$suggestion(
      brands: brands == _undefined || brands == null
          ? _instance.brands
          : (brands as List<Fragment$SuggestionBrandFragment>),
      keywords: keywords == _undefined || keywords == null
          ? _instance.keywords
          : (keywords as List<Fragment$SuggestionKeywordFragment>),
      products: products == _undefined || products == null
          ? _instance.products
          : (products as List<Fragment$SuggestionProductFragment>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes brands(
    Iterable<Fragment$SuggestionBrandFragment> Function(
      Iterable<
        CopyWith$Fragment$SuggestionBrandFragment<
          Fragment$SuggestionBrandFragment
        >
      >,
    )
    _fn,
  ) => call(
    brands: _fn(
      _instance.brands.map(
        (e) => CopyWith$Fragment$SuggestionBrandFragment(e, (i) => i),
      ),
    ).toList(),
  );

  TRes keywords(
    Iterable<Fragment$SuggestionKeywordFragment> Function(
      Iterable<
        CopyWith$Fragment$SuggestionKeywordFragment<
          Fragment$SuggestionKeywordFragment
        >
      >,
    )
    _fn,
  ) => call(
    keywords: _fn(
      _instance.keywords.map(
        (e) => CopyWith$Fragment$SuggestionKeywordFragment(e, (i) => i),
      ),
    ).toList(),
  );

  TRes products(
    Iterable<Fragment$SuggestionProductFragment> Function(
      Iterable<
        CopyWith$Fragment$SuggestionProductFragment<
          Fragment$SuggestionProductFragment
        >
      >,
    )
    _fn,
  ) => call(
    products: _fn(
      _instance.products.map(
        (e) => CopyWith$Fragment$SuggestionProductFragment(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetSuggestions$suggestion<TRes>
    implements CopyWith$Query$GetSuggestions$suggestion<TRes> {
  _CopyWithStubImpl$Query$GetSuggestions$suggestion(this._res);

  TRes _res;

  call({
    List<Fragment$SuggestionBrandFragment>? brands,
    List<Fragment$SuggestionKeywordFragment>? keywords,
    List<Fragment$SuggestionProductFragment>? products,
    String? $__typename,
  }) => _res;

  brands(_fn) => _res;

  keywords(_fn) => _res;

  products(_fn) => _res;
}
