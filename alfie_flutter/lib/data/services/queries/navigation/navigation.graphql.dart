import '../../../../schema.graphql.dart';
import '../fragments/attributes_fragment.graphql.dart';
import '../fragments/media_fragment.graphql.dart';
import 'dart:async';
import 'fragments/nav_menu_item_fragment.graphql.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$GetHeaderNav {
  factory Variables$Query$GetHeaderNav({
    required String handle,
    required bool fetchMedia,
    required bool fetchSubItems,
  }) => Variables$Query$GetHeaderNav._({
    r'handle': handle,
    r'fetchMedia': fetchMedia,
    r'fetchSubItems': fetchSubItems,
  });

  Variables$Query$GetHeaderNav._(this._$data);

  factory Variables$Query$GetHeaderNav.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$handle = data['handle'];
    result$data['handle'] = (l$handle as String);
    final l$fetchMedia = data['fetchMedia'];
    result$data['fetchMedia'] = (l$fetchMedia as bool);
    final l$fetchSubItems = data['fetchSubItems'];
    result$data['fetchSubItems'] = (l$fetchSubItems as bool);
    return Variables$Query$GetHeaderNav._(result$data);
  }

  Map<String, dynamic> _$data;

  String get handle => (_$data['handle'] as String);

  bool get fetchMedia => (_$data['fetchMedia'] as bool);

  bool get fetchSubItems => (_$data['fetchSubItems'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$handle = handle;
    result$data['handle'] = l$handle;
    final l$fetchMedia = fetchMedia;
    result$data['fetchMedia'] = l$fetchMedia;
    final l$fetchSubItems = fetchSubItems;
    result$data['fetchSubItems'] = l$fetchSubItems;
    return result$data;
  }

  CopyWith$Variables$Query$GetHeaderNav<Variables$Query$GetHeaderNav>
  get copyWith => CopyWith$Variables$Query$GetHeaderNav(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetHeaderNav ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$handle = handle;
    final lOther$handle = other.handle;
    if (l$handle != lOther$handle) {
      return false;
    }
    final l$fetchMedia = fetchMedia;
    final lOther$fetchMedia = other.fetchMedia;
    if (l$fetchMedia != lOther$fetchMedia) {
      return false;
    }
    final l$fetchSubItems = fetchSubItems;
    final lOther$fetchSubItems = other.fetchSubItems;
    if (l$fetchSubItems != lOther$fetchSubItems) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$handle = handle;
    final l$fetchMedia = fetchMedia;
    final l$fetchSubItems = fetchSubItems;
    return Object.hashAll([l$handle, l$fetchMedia, l$fetchSubItems]);
  }
}

abstract class CopyWith$Variables$Query$GetHeaderNav<TRes> {
  factory CopyWith$Variables$Query$GetHeaderNav(
    Variables$Query$GetHeaderNav instance,
    TRes Function(Variables$Query$GetHeaderNav) then,
  ) = _CopyWithImpl$Variables$Query$GetHeaderNav;

  factory CopyWith$Variables$Query$GetHeaderNav.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetHeaderNav;

  TRes call({String? handle, bool? fetchMedia, bool? fetchSubItems});
}

class _CopyWithImpl$Variables$Query$GetHeaderNav<TRes>
    implements CopyWith$Variables$Query$GetHeaderNav<TRes> {
  _CopyWithImpl$Variables$Query$GetHeaderNav(this._instance, this._then);

  final Variables$Query$GetHeaderNav _instance;

  final TRes Function(Variables$Query$GetHeaderNav) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? handle = _undefined,
    Object? fetchMedia = _undefined,
    Object? fetchSubItems = _undefined,
  }) => _then(
    Variables$Query$GetHeaderNav._({
      ..._instance._$data,
      if (handle != _undefined && handle != null) 'handle': (handle as String),
      if (fetchMedia != _undefined && fetchMedia != null)
        'fetchMedia': (fetchMedia as bool),
      if (fetchSubItems != _undefined && fetchSubItems != null)
        'fetchSubItems': (fetchSubItems as bool),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetHeaderNav<TRes>
    implements CopyWith$Variables$Query$GetHeaderNav<TRes> {
  _CopyWithStubImpl$Variables$Query$GetHeaderNav(this._res);

  TRes _res;

  call({String? handle, bool? fetchMedia, bool? fetchSubItems}) => _res;
}

class Query$GetHeaderNav {
  Query$GetHeaderNav({required this.navigation, this.$__typename = 'Query'});

  factory Query$GetHeaderNav.fromJson(Map<String, dynamic> json) {
    final l$navigation = json['navigation'];
    final l$$__typename = json['__typename'];
    return Query$GetHeaderNav(
      navigation: (l$navigation as List<dynamic>)
          .map(
            (e) => Query$GetHeaderNav$navigation.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetHeaderNav$navigation> navigation;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$navigation = navigation;
    _resultData['navigation'] = l$navigation.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$navigation = navigation;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$navigation.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetHeaderNav || runtimeType != other.runtimeType) {
      return false;
    }
    final l$navigation = navigation;
    final lOther$navigation = other.navigation;
    if (l$navigation.length != lOther$navigation.length) {
      return false;
    }
    for (int i = 0; i < l$navigation.length; i++) {
      final l$navigation$entry = l$navigation[i];
      final lOther$navigation$entry = lOther$navigation[i];
      if (l$navigation$entry != lOther$navigation$entry) {
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

extension UtilityExtension$Query$GetHeaderNav on Query$GetHeaderNav {
  CopyWith$Query$GetHeaderNav<Query$GetHeaderNav> get copyWith =>
      CopyWith$Query$GetHeaderNav(this, (i) => i);
}

abstract class CopyWith$Query$GetHeaderNav<TRes> {
  factory CopyWith$Query$GetHeaderNav(
    Query$GetHeaderNav instance,
    TRes Function(Query$GetHeaderNav) then,
  ) = _CopyWithImpl$Query$GetHeaderNav;

  factory CopyWith$Query$GetHeaderNav.stub(TRes res) =
      _CopyWithStubImpl$Query$GetHeaderNav;

  TRes call({
    List<Query$GetHeaderNav$navigation>? navigation,
    String? $__typename,
  });
  TRes navigation(
    Iterable<Query$GetHeaderNav$navigation> Function(
      Iterable<
        CopyWith$Query$GetHeaderNav$navigation<Query$GetHeaderNav$navigation>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetHeaderNav<TRes>
    implements CopyWith$Query$GetHeaderNav<TRes> {
  _CopyWithImpl$Query$GetHeaderNav(this._instance, this._then);

  final Query$GetHeaderNav _instance;

  final TRes Function(Query$GetHeaderNav) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? navigation = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetHeaderNav(
      navigation: navigation == _undefined || navigation == null
          ? _instance.navigation
          : (navigation as List<Query$GetHeaderNav$navigation>),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes navigation(
    Iterable<Query$GetHeaderNav$navigation> Function(
      Iterable<
        CopyWith$Query$GetHeaderNav$navigation<Query$GetHeaderNav$navigation>
      >,
    )
    _fn,
  ) => call(
    navigation: _fn(
      _instance.navigation.map(
        (e) => CopyWith$Query$GetHeaderNav$navigation(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetHeaderNav<TRes>
    implements CopyWith$Query$GetHeaderNav<TRes> {
  _CopyWithStubImpl$Query$GetHeaderNav(this._res);

  TRes _res;

  call({
    List<Query$GetHeaderNav$navigation>? navigation,
    String? $__typename,
  }) => _res;

  navigation(_fn) => _res;
}

const documentNodeQueryGetHeaderNav = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetHeaderNav'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'handle')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'fetchMedia')),
          type: NamedTypeNode(
            name: NameNode(value: 'Boolean'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'fetchSubItems')),
          type: NamedTypeNode(
            name: NameNode(value: 'Boolean'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'navigation'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'handle'),
                value: VariableNode(name: NameNode(value: 'handle')),
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
                  name: NameNode(value: 'type'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'url'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'media'),
                  alias: null,
                  arguments: [],
                  directives: [
                    DirectiveNode(
                      name: NameNode(value: 'include'),
                      arguments: [
                        ArgumentNode(
                          name: NameNode(value: 'if'),
                          value: VariableNode(
                            name: NameNode(value: 'fetchMedia'),
                          ),
                        ),
                      ],
                    ),
                  ],
                  selectionSet: SelectionSetNode(
                    selections: [
                      InlineFragmentNode(
                        typeCondition: TypeConditionNode(
                          on: NamedTypeNode(
                            name: NameNode(value: 'Image'),
                            isNonNull: false,
                          ),
                        ),
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'ImageFragment'),
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
                  name: NameNode(value: 'items'),
                  alias: null,
                  arguments: [],
                  directives: [
                    DirectiveNode(
                      name: NameNode(value: 'include'),
                      arguments: [
                        ArgumentNode(
                          name: NameNode(value: 'if'),
                          value: VariableNode(
                            name: NameNode(value: 'fetchSubItems'),
                          ),
                        ),
                      ],
                    ),
                  ],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'NavMenuItemFragment'),
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
    fragmentDefinitionImageFragment,
    fragmentDefinitionNavMenuItemFragment,
    fragmentDefinitionAttributesFragment,
  ],
);
Query$GetHeaderNav _parserFn$Query$GetHeaderNav(Map<String, dynamic> data) =>
    Query$GetHeaderNav.fromJson(data);
typedef OnQueryComplete$Query$GetHeaderNav =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetHeaderNav?);

class Options$Query$GetHeaderNav
    extends graphql.QueryOptions<Query$GetHeaderNav> {
  Options$Query$GetHeaderNav({
    String? operationName,
    required Variables$Query$GetHeaderNav variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetHeaderNav? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetHeaderNav? onComplete,
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
                 data == null ? null : _parserFn$Query$GetHeaderNav(data),
               ),
         onError: onError,
         document: documentNodeQueryGetHeaderNav,
         parserFn: _parserFn$Query$GetHeaderNav,
       );

  final OnQueryComplete$Query$GetHeaderNav? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetHeaderNav
    extends graphql.WatchQueryOptions<Query$GetHeaderNav> {
  WatchOptions$Query$GetHeaderNav({
    String? operationName,
    required Variables$Query$GetHeaderNav variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetHeaderNav? typedOptimisticResult,
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
         document: documentNodeQueryGetHeaderNav,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetHeaderNav,
       );
}

class FetchMoreOptions$Query$GetHeaderNav extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetHeaderNav({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetHeaderNav variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGetHeaderNav,
       );
}

extension ClientExtension$Query$GetHeaderNav on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetHeaderNav>> query$GetHeaderNav(
    Options$Query$GetHeaderNav options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$GetHeaderNav> watchQuery$GetHeaderNav(
    WatchOptions$Query$GetHeaderNav options,
  ) => this.watchQuery(options);

  void writeQuery$GetHeaderNav({
    required Query$GetHeaderNav data,
    required Variables$Query$GetHeaderNav variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetHeaderNav),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$GetHeaderNav? readQuery$GetHeaderNav({
    required Variables$Query$GetHeaderNav variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetHeaderNav),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetHeaderNav.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetHeaderNav> useQuery$GetHeaderNav(
  Options$Query$GetHeaderNav options,
) => graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetHeaderNav> useWatchQuery$GetHeaderNav(
  WatchOptions$Query$GetHeaderNav options,
) => graphql_flutter.useWatchQuery(options);

class Query$GetHeaderNav$Widget
    extends graphql_flutter.Query<Query$GetHeaderNav> {
  Query$GetHeaderNav$Widget({
    widgets.Key? key,
    required Options$Query$GetHeaderNav options,
    required graphql_flutter.QueryBuilder<Query$GetHeaderNav> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Query$GetHeaderNav$navigation {
  Query$GetHeaderNav$navigation({
    required this.title,
    required this.type,
    this.url,
    this.media,
    this.items,
    this.attributes,
    this.$__typename = 'NavMenuItem',
  });

  factory Query$GetHeaderNav$navigation.fromJson(Map<String, dynamic> json) {
    final l$title = json['title'];
    final l$type = json['type'];
    final l$url = json['url'];
    final l$media = json['media'];
    final l$items = json['items'];
    final l$attributes = json['attributes'];
    final l$$__typename = json['__typename'];
    return Query$GetHeaderNav$navigation(
      title: (l$title as String),
      type: fromJson$Enum$NavMenuItemType((l$type as String)),
      url: (l$url as String?),
      media: l$media == null
          ? null
          : Query$GetHeaderNav$navigation$media.fromJson(
              (l$media as Map<String, dynamic>),
            ),
      items: (l$items as List<dynamic>?)
          ?.map(
            (e) => Fragment$NavMenuItemFragment.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      attributes: (l$attributes as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : Fragment$AttributesFragment.fromJson(
                    (e as Map<String, dynamic>),
                  ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String title;

  final Enum$NavMenuItemType type;

  final String? url;

  final Query$GetHeaderNav$navigation$media? media;

  final List<Fragment$NavMenuItemFragment>? items;

  final List<Fragment$AttributesFragment?>? attributes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$title = title;
    _resultData['title'] = l$title;
    final l$type = type;
    _resultData['type'] = toJson$Enum$NavMenuItemType(l$type);
    final l$url = url;
    _resultData['url'] = l$url;
    final l$media = media;
    _resultData['media'] = l$media?.toJson();
    final l$items = items;
    _resultData['items'] = l$items?.map((e) => e.toJson()).toList();
    final l$attributes = attributes;
    _resultData['attributes'] = l$attributes?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$type = type;
    final l$url = url;
    final l$media = media;
    final l$items = items;
    final l$attributes = attributes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$title,
      l$type,
      l$url,
      l$media,
      l$items == null ? null : Object.hashAll(l$items.map((v) => v)),
      l$attributes == null ? null : Object.hashAll(l$attributes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetHeaderNav$navigation ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) {
      return false;
    }
    final l$media = media;
    final lOther$media = other.media;
    if (l$media != lOther$media) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items != null && lOther$items != null) {
      if (l$items.length != lOther$items.length) {
        return false;
      }
      for (int i = 0; i < l$items.length; i++) {
        final l$items$entry = l$items[i];
        final lOther$items$entry = lOther$items[i];
        if (l$items$entry != lOther$items$entry) {
          return false;
        }
      }
    } else if (l$items != lOther$items) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetHeaderNav$navigation
    on Query$GetHeaderNav$navigation {
  CopyWith$Query$GetHeaderNav$navigation<Query$GetHeaderNav$navigation>
  get copyWith => CopyWith$Query$GetHeaderNav$navigation(this, (i) => i);
}

abstract class CopyWith$Query$GetHeaderNav$navigation<TRes> {
  factory CopyWith$Query$GetHeaderNav$navigation(
    Query$GetHeaderNav$navigation instance,
    TRes Function(Query$GetHeaderNav$navigation) then,
  ) = _CopyWithImpl$Query$GetHeaderNav$navigation;

  factory CopyWith$Query$GetHeaderNav$navigation.stub(TRes res) =
      _CopyWithStubImpl$Query$GetHeaderNav$navigation;

  TRes call({
    String? title,
    Enum$NavMenuItemType? type,
    String? url,
    Query$GetHeaderNav$navigation$media? media,
    List<Fragment$NavMenuItemFragment>? items,
    List<Fragment$AttributesFragment?>? attributes,
    String? $__typename,
  });
  CopyWith$Query$GetHeaderNav$navigation$media<TRes> get media;
  TRes items(
    Iterable<Fragment$NavMenuItemFragment>? Function(
      Iterable<
        CopyWith$Fragment$NavMenuItemFragment<Fragment$NavMenuItemFragment>
      >?,
    )
    _fn,
  );
  TRes attributes(
    Iterable<Fragment$AttributesFragment?>? Function(
      Iterable<
        CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>?
      >?,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetHeaderNav$navigation<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation<TRes> {
  _CopyWithImpl$Query$GetHeaderNav$navigation(this._instance, this._then);

  final Query$GetHeaderNav$navigation _instance;

  final TRes Function(Query$GetHeaderNav$navigation) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? type = _undefined,
    Object? url = _undefined,
    Object? media = _undefined,
    Object? items = _undefined,
    Object? attributes = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetHeaderNav$navigation(
      title: title == _undefined || title == null
          ? _instance.title
          : (title as String),
      type: type == _undefined || type == null
          ? _instance.type
          : (type as Enum$NavMenuItemType),
      url: url == _undefined ? _instance.url : (url as String?),
      media: media == _undefined
          ? _instance.media
          : (media as Query$GetHeaderNav$navigation$media?),
      items: items == _undefined
          ? _instance.items
          : (items as List<Fragment$NavMenuItemFragment>?),
      attributes: attributes == _undefined
          ? _instance.attributes
          : (attributes as List<Fragment$AttributesFragment?>?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$GetHeaderNav$navigation$media<TRes> get media {
    final local$media = _instance.media;
    return local$media == null
        ? CopyWith$Query$GetHeaderNav$navigation$media.stub(_then(_instance))
        : CopyWith$Query$GetHeaderNav$navigation$media(
            local$media,
            (e) => call(media: e),
          );
  }

  TRes items(
    Iterable<Fragment$NavMenuItemFragment>? Function(
      Iterable<
        CopyWith$Fragment$NavMenuItemFragment<Fragment$NavMenuItemFragment>
      >?,
    )
    _fn,
  ) => call(
    items: _fn(
      _instance.items?.map(
        (e) => CopyWith$Fragment$NavMenuItemFragment(e, (i) => i),
      ),
    )?.toList(),
  );

  TRes attributes(
    Iterable<Fragment$AttributesFragment?>? Function(
      Iterable<
        CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>?
      >?,
    )
    _fn,
  ) => call(
    attributes: _fn(
      _instance.attributes?.map(
        (e) => e == null
            ? null
            : CopyWith$Fragment$AttributesFragment(e, (i) => i),
      ),
    )?.toList(),
  );
}

class _CopyWithStubImpl$Query$GetHeaderNav$navigation<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation<TRes> {
  _CopyWithStubImpl$Query$GetHeaderNav$navigation(this._res);

  TRes _res;

  call({
    String? title,
    Enum$NavMenuItemType? type,
    String? url,
    Query$GetHeaderNav$navigation$media? media,
    List<Fragment$NavMenuItemFragment>? items,
    List<Fragment$AttributesFragment?>? attributes,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetHeaderNav$navigation$media<TRes> get media =>
      CopyWith$Query$GetHeaderNav$navigation$media.stub(_res);

  items(_fn) => _res;

  attributes(_fn) => _res;
}

class Query$GetHeaderNav$navigation$media {
  Query$GetHeaderNav$navigation$media({required this.$__typename});

  factory Query$GetHeaderNav$navigation$media.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "Image":
        return Query$GetHeaderNav$navigation$media$$Image.fromJson(json);

      case "Video":
        return Query$GetHeaderNav$navigation$media$$Video.fromJson(json);

      default:
        final l$$__typename = json['__typename'];
        return Query$GetHeaderNav$navigation$media(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetHeaderNav$navigation$media ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$GetHeaderNav$navigation$media
    on Query$GetHeaderNav$navigation$media {
  CopyWith$Query$GetHeaderNav$navigation$media<
    Query$GetHeaderNav$navigation$media
  >
  get copyWith => CopyWith$Query$GetHeaderNav$navigation$media(this, (i) => i);

  _T when<_T>({
    required _T Function(Query$GetHeaderNav$navigation$media$$Image) image,
    required _T Function(Query$GetHeaderNav$navigation$media$$Video) video,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "Image":
        return image(this as Query$GetHeaderNav$navigation$media$$Image);

      case "Video":
        return video(this as Query$GetHeaderNav$navigation$media$$Video);

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(Query$GetHeaderNav$navigation$media$$Image)? image,
    _T Function(Query$GetHeaderNav$navigation$media$$Video)? video,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "Image":
        if (image != null) {
          return image(this as Query$GetHeaderNav$navigation$media$$Image);
        } else {
          return orElse();
        }

      case "Video":
        if (video != null) {
          return video(this as Query$GetHeaderNav$navigation$media$$Video);
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetHeaderNav$navigation$media<TRes> {
  factory CopyWith$Query$GetHeaderNav$navigation$media(
    Query$GetHeaderNav$navigation$media instance,
    TRes Function(Query$GetHeaderNav$navigation$media) then,
  ) = _CopyWithImpl$Query$GetHeaderNav$navigation$media;

  factory CopyWith$Query$GetHeaderNav$navigation$media.stub(TRes res) =
      _CopyWithStubImpl$Query$GetHeaderNav$navigation$media;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetHeaderNav$navigation$media<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation$media<TRes> {
  _CopyWithImpl$Query$GetHeaderNav$navigation$media(this._instance, this._then);

  final Query$GetHeaderNav$navigation$media _instance;

  final TRes Function(Query$GetHeaderNav$navigation$media) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetHeaderNav$navigation$media(
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetHeaderNav$navigation$media<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation$media<TRes> {
  _CopyWithStubImpl$Query$GetHeaderNav$navigation$media(this._res);

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetHeaderNav$navigation$media$$Image
    implements Fragment$ImageFragment, Query$GetHeaderNav$navigation$media {
  Query$GetHeaderNav$navigation$media$$Image({
    this.alt,
    required this.mediaContentType,
    required this.url,
    this.$__typename = 'Image',
  });

  factory Query$GetHeaderNav$navigation$media$$Image.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$alt = json['alt'];
    final l$mediaContentType = json['mediaContentType'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Query$GetHeaderNav$navigation$media$$Image(
      alt: (l$alt as String?),
      mediaContentType: fromJson$Enum$MediaContentType(
        (l$mediaContentType as String),
      ),
      url: (l$url as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String? alt;

  final Enum$MediaContentType mediaContentType;

  final String url;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$alt = alt;
    _resultData['alt'] = l$alt;
    final l$mediaContentType = mediaContentType;
    _resultData['mediaContentType'] = toJson$Enum$MediaContentType(
      l$mediaContentType,
    );
    final l$url = url;
    _resultData['url'] = l$url;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$alt = alt;
    final l$mediaContentType = mediaContentType;
    final l$url = url;
    final l$$__typename = $__typename;
    return Object.hashAll([l$alt, l$mediaContentType, l$url, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetHeaderNav$navigation$media$$Image ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$alt = alt;
    final lOther$alt = other.alt;
    if (l$alt != lOther$alt) {
      return false;
    }
    final l$mediaContentType = mediaContentType;
    final lOther$mediaContentType = other.mediaContentType;
    if (l$mediaContentType != lOther$mediaContentType) {
      return false;
    }
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) {
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

extension UtilityExtension$Query$GetHeaderNav$navigation$media$$Image
    on Query$GetHeaderNav$navigation$media$$Image {
  CopyWith$Query$GetHeaderNav$navigation$media$$Image<
    Query$GetHeaderNav$navigation$media$$Image
  >
  get copyWith =>
      CopyWith$Query$GetHeaderNav$navigation$media$$Image(this, (i) => i);
}

abstract class CopyWith$Query$GetHeaderNav$navigation$media$$Image<TRes> {
  factory CopyWith$Query$GetHeaderNav$navigation$media$$Image(
    Query$GetHeaderNav$navigation$media$$Image instance,
    TRes Function(Query$GetHeaderNav$navigation$media$$Image) then,
  ) = _CopyWithImpl$Query$GetHeaderNav$navigation$media$$Image;

  factory CopyWith$Query$GetHeaderNav$navigation$media$$Image.stub(TRes res) =
      _CopyWithStubImpl$Query$GetHeaderNav$navigation$media$$Image;

  TRes call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetHeaderNav$navigation$media$$Image<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation$media$$Image<TRes> {
  _CopyWithImpl$Query$GetHeaderNav$navigation$media$$Image(
    this._instance,
    this._then,
  );

  final Query$GetHeaderNav$navigation$media$$Image _instance;

  final TRes Function(Query$GetHeaderNav$navigation$media$$Image) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? alt = _undefined,
    Object? mediaContentType = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetHeaderNav$navigation$media$$Image(
      alt: alt == _undefined ? _instance.alt : (alt as String?),
      mediaContentType:
          mediaContentType == _undefined || mediaContentType == null
          ? _instance.mediaContentType
          : (mediaContentType as Enum$MediaContentType),
      url: url == _undefined || url == null ? _instance.url : (url as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetHeaderNav$navigation$media$$Image<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation$media$$Image<TRes> {
  _CopyWithStubImpl$Query$GetHeaderNav$navigation$media$$Image(this._res);

  TRes _res;

  call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  }) => _res;
}

class Query$GetHeaderNav$navigation$media$$Video
    implements Query$GetHeaderNav$navigation$media {
  Query$GetHeaderNav$navigation$media$$Video({this.$__typename = 'Video'});

  factory Query$GetHeaderNav$navigation$media$$Video.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$$__typename = json['__typename'];
    return Query$GetHeaderNav$navigation$media$$Video(
      $__typename: (l$$__typename as String),
    );
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetHeaderNav$navigation$media$$Video ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$GetHeaderNav$navigation$media$$Video
    on Query$GetHeaderNav$navigation$media$$Video {
  CopyWith$Query$GetHeaderNav$navigation$media$$Video<
    Query$GetHeaderNav$navigation$media$$Video
  >
  get copyWith =>
      CopyWith$Query$GetHeaderNav$navigation$media$$Video(this, (i) => i);
}

abstract class CopyWith$Query$GetHeaderNav$navigation$media$$Video<TRes> {
  factory CopyWith$Query$GetHeaderNav$navigation$media$$Video(
    Query$GetHeaderNav$navigation$media$$Video instance,
    TRes Function(Query$GetHeaderNav$navigation$media$$Video) then,
  ) = _CopyWithImpl$Query$GetHeaderNav$navigation$media$$Video;

  factory CopyWith$Query$GetHeaderNav$navigation$media$$Video.stub(TRes res) =
      _CopyWithStubImpl$Query$GetHeaderNav$navigation$media$$Video;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetHeaderNav$navigation$media$$Video<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation$media$$Video<TRes> {
  _CopyWithImpl$Query$GetHeaderNav$navigation$media$$Video(
    this._instance,
    this._then,
  );

  final Query$GetHeaderNav$navigation$media$$Video _instance;

  final TRes Function(Query$GetHeaderNav$navigation$media$$Video) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetHeaderNav$navigation$media$$Video(
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetHeaderNav$navigation$media$$Video<TRes>
    implements CopyWith$Query$GetHeaderNav$navigation$media$$Video<TRes> {
  _CopyWithStubImpl$Query$GetHeaderNav$navigation$media$$Video(this._res);

  TRes _res;

  call({String? $__typename}) => _res;
}
