import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$PaginationFragment {
  Fragment$PaginationFragment({
    required this.offset,
    required this.limit,
    required this.total,
    required this.pages,
    required this.page,
    this.nextPage,
    this.previousPage,
    this.$__typename = 'Pagination',
  });

  factory Fragment$PaginationFragment.fromJson(Map<String, dynamic> json) {
    final l$offset = json['offset'];
    final l$limit = json['limit'];
    final l$total = json['total'];
    final l$pages = json['pages'];
    final l$page = json['page'];
    final l$nextPage = json['nextPage'];
    final l$previousPage = json['previousPage'];
    final l$$__typename = json['__typename'];
    return Fragment$PaginationFragment(
      offset: (l$offset as int),
      limit: (l$limit as int),
      total: (l$total as int),
      pages: (l$pages as int),
      page: (l$page as int),
      nextPage: (l$nextPage as int?),
      previousPage: (l$previousPage as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final int offset;

  final int limit;

  final int total;

  final int pages;

  final int page;

  final int? nextPage;

  final int? previousPage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$offset = offset;
    _resultData['offset'] = l$offset;
    final l$limit = limit;
    _resultData['limit'] = l$limit;
    final l$total = total;
    _resultData['total'] = l$total;
    final l$pages = pages;
    _resultData['pages'] = l$pages;
    final l$page = page;
    _resultData['page'] = l$page;
    final l$nextPage = nextPage;
    _resultData['nextPage'] = l$nextPage;
    final l$previousPage = previousPage;
    _resultData['previousPage'] = l$previousPage;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$offset = offset;
    final l$limit = limit;
    final l$total = total;
    final l$pages = pages;
    final l$page = page;
    final l$nextPage = nextPage;
    final l$previousPage = previousPage;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$offset,
      l$limit,
      l$total,
      l$pages,
      l$page,
      l$nextPage,
      l$previousPage,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$PaginationFragment ||
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
    final l$total = total;
    final lOther$total = other.total;
    if (l$total != lOther$total) {
      return false;
    }
    final l$pages = pages;
    final lOther$pages = other.pages;
    if (l$pages != lOther$pages) {
      return false;
    }
    final l$page = page;
    final lOther$page = other.page;
    if (l$page != lOther$page) {
      return false;
    }
    final l$nextPage = nextPage;
    final lOther$nextPage = other.nextPage;
    if (l$nextPage != lOther$nextPage) {
      return false;
    }
    final l$previousPage = previousPage;
    final lOther$previousPage = other.previousPage;
    if (l$previousPage != lOther$previousPage) {
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

extension UtilityExtension$Fragment$PaginationFragment
    on Fragment$PaginationFragment {
  CopyWith$Fragment$PaginationFragment<Fragment$PaginationFragment>
  get copyWith => CopyWith$Fragment$PaginationFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$PaginationFragment<TRes> {
  factory CopyWith$Fragment$PaginationFragment(
    Fragment$PaginationFragment instance,
    TRes Function(Fragment$PaginationFragment) then,
  ) = _CopyWithImpl$Fragment$PaginationFragment;

  factory CopyWith$Fragment$PaginationFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$PaginationFragment;

  TRes call({
    int? offset,
    int? limit,
    int? total,
    int? pages,
    int? page,
    int? nextPage,
    int? previousPage,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$PaginationFragment<TRes>
    implements CopyWith$Fragment$PaginationFragment<TRes> {
  _CopyWithImpl$Fragment$PaginationFragment(this._instance, this._then);

  final Fragment$PaginationFragment _instance;

  final TRes Function(Fragment$PaginationFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? offset = _undefined,
    Object? limit = _undefined,
    Object? total = _undefined,
    Object? pages = _undefined,
    Object? page = _undefined,
    Object? nextPage = _undefined,
    Object? previousPage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$PaginationFragment(
      offset: offset == _undefined || offset == null
          ? _instance.offset
          : (offset as int),
      limit: limit == _undefined || limit == null
          ? _instance.limit
          : (limit as int),
      total: total == _undefined || total == null
          ? _instance.total
          : (total as int),
      pages: pages == _undefined || pages == null
          ? _instance.pages
          : (pages as int),
      page: page == _undefined || page == null ? _instance.page : (page as int),
      nextPage: nextPage == _undefined
          ? _instance.nextPage
          : (nextPage as int?),
      previousPage: previousPage == _undefined
          ? _instance.previousPage
          : (previousPage as int?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$PaginationFragment<TRes>
    implements CopyWith$Fragment$PaginationFragment<TRes> {
  _CopyWithStubImpl$Fragment$PaginationFragment(this._res);

  TRes _res;

  call({
    int? offset,
    int? limit,
    int? total,
    int? pages,
    int? page,
    int? nextPage,
    int? previousPage,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionPaginationFragment = FragmentDefinitionNode(
  name: NameNode(value: 'PaginationFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Pagination'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'offset'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'limit'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'total'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'pages'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'page'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'nextPage'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'previousPage'),
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
const documentNodeFragmentPaginationFragment = DocumentNode(
  definitions: [fragmentDefinitionPaginationFragment],
);

extension ClientExtension$Fragment$PaginationFragment on graphql.GraphQLClient {
  void writeFragment$PaginationFragment({
    required Fragment$PaginationFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'PaginationFragment',
        document: documentNodeFragmentPaginationFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$PaginationFragment? readFragment$PaginationFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'PaginationFragment',
          document: documentNodeFragmentPaginationFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$PaginationFragment.fromJson(result);
  }
}
