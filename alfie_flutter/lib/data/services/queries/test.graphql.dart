import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Query$GetTest {
  Query$GetTest({required this.$__schema, this.$__typename = 'Query'});

  factory Query$GetTest.fromJson(Map<String, dynamic> json) {
    final l$$__schema = json['__schema'];
    final l$$__typename = json['__typename'];
    return Query$GetTest(
      $__schema: Query$GetTest$__schema.fromJson(
        (l$$__schema as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetTest$__schema $__schema;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__schema = $__schema;
    _resultData['__schema'] = l$$__schema.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__schema = $__schema;
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__schema, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetTest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__schema = $__schema;
    final lOther$$__schema = other.$__schema;
    if (l$$__schema != lOther$$__schema) {
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

extension UtilityExtension$Query$GetTest on Query$GetTest {
  CopyWith$Query$GetTest<Query$GetTest> get copyWith =>
      CopyWith$Query$GetTest(this, (i) => i);
}

abstract class CopyWith$Query$GetTest<TRes> {
  factory CopyWith$Query$GetTest(
    Query$GetTest instance,
    TRes Function(Query$GetTest) then,
  ) = _CopyWithImpl$Query$GetTest;

  factory CopyWith$Query$GetTest.stub(TRes res) =
      _CopyWithStubImpl$Query$GetTest;

  TRes call({Query$GetTest$__schema? $__schema, String? $__typename});
  CopyWith$Query$GetTest$__schema<TRes> get $__schema;
}

class _CopyWithImpl$Query$GetTest<TRes>
    implements CopyWith$Query$GetTest<TRes> {
  _CopyWithImpl$Query$GetTest(this._instance, this._then);

  final Query$GetTest _instance;

  final TRes Function(Query$GetTest) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $__schema = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetTest(
      $__schema: $__schema == _undefined || $__schema == null
          ? _instance.$__schema
          : ($__schema as Query$GetTest$__schema),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$GetTest$__schema<TRes> get $__schema {
    final local$$__schema = _instance.$__schema;
    return CopyWith$Query$GetTest$__schema(
      local$$__schema,
      (e) => call($__schema: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetTest<TRes>
    implements CopyWith$Query$GetTest<TRes> {
  _CopyWithStubImpl$Query$GetTest(this._res);

  TRes _res;

  call({Query$GetTest$__schema? $__schema, String? $__typename}) => _res;

  CopyWith$Query$GetTest$__schema<TRes> get $__schema =>
      CopyWith$Query$GetTest$__schema.stub(_res);
}

const documentNodeQueryGetTest = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetTest'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: '__schema'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'types'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'name'),
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
  ],
);
Query$GetTest _parserFn$Query$GetTest(Map<String, dynamic> data) =>
    Query$GetTest.fromJson(data);
typedef OnQueryComplete$Query$GetTest =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetTest?);

class Options$Query$GetTest extends graphql.QueryOptions<Query$GetTest> {
  Options$Query$GetTest({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetTest? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetTest? onComplete,
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
                 data == null ? null : _parserFn$Query$GetTest(data),
               ),
         onError: onError,
         document: documentNodeQueryGetTest,
         parserFn: _parserFn$Query$GetTest,
       );

  final OnQueryComplete$Query$GetTest? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetTest
    extends graphql.WatchQueryOptions<Query$GetTest> {
  WatchOptions$Query$GetTest({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetTest? typedOptimisticResult,
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
         document: documentNodeQueryGetTest,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetTest,
       );
}

class FetchMoreOptions$Query$GetTest extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetTest({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryGetTest);
}

extension ClientExtension$Query$GetTest on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetTest>> query$GetTest([
    Options$Query$GetTest? options,
  ]) async => await this.query(options ?? Options$Query$GetTest());

  graphql.ObservableQuery<Query$GetTest> watchQuery$GetTest([
    WatchOptions$Query$GetTest? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$GetTest());

  void writeQuery$GetTest({
    required Query$GetTest data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetTest),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$GetTest? readQuery$GetTest({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetTest),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetTest.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetTest> useQuery$GetTest([
  Options$Query$GetTest? options,
]) => graphql_flutter.useQuery(options ?? Options$Query$GetTest());
graphql.ObservableQuery<Query$GetTest> useWatchQuery$GetTest([
  WatchOptions$Query$GetTest? options,
]) => graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$GetTest());

class Query$GetTest$Widget extends graphql_flutter.Query<Query$GetTest> {
  Query$GetTest$Widget({
    widgets.Key? key,
    Options$Query$GetTest? options,
    required graphql_flutter.QueryBuilder<Query$GetTest> builder,
  }) : super(
         key: key,
         options: options ?? Options$Query$GetTest(),
         builder: builder,
       );
}

class Query$GetTest$__schema {
  Query$GetTest$__schema({required this.types, this.$__typename = '__Schema'});

  factory Query$GetTest$__schema.fromJson(Map<String, dynamic> json) {
    final l$types = json['types'];
    final l$$__typename = json['__typename'];
    return Query$GetTest$__schema(
      types: (l$types as List<dynamic>)
          .map(
            (e) => Query$GetTest$__schema$types.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetTest$__schema$types> types;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$types = types;
    _resultData['types'] = l$types.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$types = types;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$types.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetTest$__schema || runtimeType != other.runtimeType) {
      return false;
    }
    final l$types = types;
    final lOther$types = other.types;
    if (l$types.length != lOther$types.length) {
      return false;
    }
    for (int i = 0; i < l$types.length; i++) {
      final l$types$entry = l$types[i];
      final lOther$types$entry = lOther$types[i];
      if (l$types$entry != lOther$types$entry) {
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

extension UtilityExtension$Query$GetTest$__schema on Query$GetTest$__schema {
  CopyWith$Query$GetTest$__schema<Query$GetTest$__schema> get copyWith =>
      CopyWith$Query$GetTest$__schema(this, (i) => i);
}

abstract class CopyWith$Query$GetTest$__schema<TRes> {
  factory CopyWith$Query$GetTest$__schema(
    Query$GetTest$__schema instance,
    TRes Function(Query$GetTest$__schema) then,
  ) = _CopyWithImpl$Query$GetTest$__schema;

  factory CopyWith$Query$GetTest$__schema.stub(TRes res) =
      _CopyWithStubImpl$Query$GetTest$__schema;

  TRes call({List<Query$GetTest$__schema$types>? types, String? $__typename});
  TRes types(
    Iterable<Query$GetTest$__schema$types> Function(
      Iterable<
        CopyWith$Query$GetTest$__schema$types<Query$GetTest$__schema$types>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetTest$__schema<TRes>
    implements CopyWith$Query$GetTest$__schema<TRes> {
  _CopyWithImpl$Query$GetTest$__schema(this._instance, this._then);

  final Query$GetTest$__schema _instance;

  final TRes Function(Query$GetTest$__schema) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? types = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetTest$__schema(
          types: types == _undefined || types == null
              ? _instance.types
              : (types as List<Query$GetTest$__schema$types>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  TRes types(
    Iterable<Query$GetTest$__schema$types> Function(
      Iterable<
        CopyWith$Query$GetTest$__schema$types<Query$GetTest$__schema$types>
      >,
    )
    _fn,
  ) => call(
    types: _fn(
      _instance.types.map(
        (e) => CopyWith$Query$GetTest$__schema$types(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetTest$__schema<TRes>
    implements CopyWith$Query$GetTest$__schema<TRes> {
  _CopyWithStubImpl$Query$GetTest$__schema(this._res);

  TRes _res;

  call({List<Query$GetTest$__schema$types>? types, String? $__typename}) =>
      _res;

  types(_fn) => _res;
}

class Query$GetTest$__schema$types {
  Query$GetTest$__schema$types({this.name, this.$__typename = '__Type'});

  factory Query$GetTest$__schema$types.fromJson(Map<String, dynamic> json) {
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$GetTest$__schema$types(
      name: (l$name as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([l$name, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetTest$__schema$types ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
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

extension UtilityExtension$Query$GetTest$__schema$types
    on Query$GetTest$__schema$types {
  CopyWith$Query$GetTest$__schema$types<Query$GetTest$__schema$types>
  get copyWith => CopyWith$Query$GetTest$__schema$types(this, (i) => i);
}

abstract class CopyWith$Query$GetTest$__schema$types<TRes> {
  factory CopyWith$Query$GetTest$__schema$types(
    Query$GetTest$__schema$types instance,
    TRes Function(Query$GetTest$__schema$types) then,
  ) = _CopyWithImpl$Query$GetTest$__schema$types;

  factory CopyWith$Query$GetTest$__schema$types.stub(TRes res) =
      _CopyWithStubImpl$Query$GetTest$__schema$types;

  TRes call({String? name, String? $__typename});
}

class _CopyWithImpl$Query$GetTest$__schema$types<TRes>
    implements CopyWith$Query$GetTest$__schema$types<TRes> {
  _CopyWithImpl$Query$GetTest$__schema$types(this._instance, this._then);

  final Query$GetTest$__schema$types _instance;

  final TRes Function(Query$GetTest$__schema$types) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetTest$__schema$types(
          name: name == _undefined ? _instance.name : (name as String?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Query$GetTest$__schema$types<TRes>
    implements CopyWith$Query$GetTest$__schema$types<TRes> {
  _CopyWithStubImpl$Query$GetTest$__schema$types(this._res);

  TRes _res;

  call({String? name, String? $__typename}) => _res;
}
