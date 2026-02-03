import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$SuggestionKeywordFragment {
  Fragment$SuggestionKeywordFragment({
    required this.value,
    required this.results,
    this.$__typename = 'SuggestionKeyword',
  });

  factory Fragment$SuggestionKeywordFragment.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$value = json['value'];
    final l$results = json['results'];
    final l$$__typename = json['__typename'];
    return Fragment$SuggestionKeywordFragment(
      value: (l$value as String),
      results: (l$results as int),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final int results;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$results = results;
    _resultData['results'] = l$results;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$results = results;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$results, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SuggestionKeywordFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$results = results;
    final lOther$results = other.results;
    if (l$results != lOther$results) {
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

extension UtilityExtension$Fragment$SuggestionKeywordFragment
    on Fragment$SuggestionKeywordFragment {
  CopyWith$Fragment$SuggestionKeywordFragment<
    Fragment$SuggestionKeywordFragment
  >
  get copyWith => CopyWith$Fragment$SuggestionKeywordFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SuggestionKeywordFragment<TRes> {
  factory CopyWith$Fragment$SuggestionKeywordFragment(
    Fragment$SuggestionKeywordFragment instance,
    TRes Function(Fragment$SuggestionKeywordFragment) then,
  ) = _CopyWithImpl$Fragment$SuggestionKeywordFragment;

  factory CopyWith$Fragment$SuggestionKeywordFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SuggestionKeywordFragment;

  TRes call({String? value, int? results, String? $__typename});
}

class _CopyWithImpl$Fragment$SuggestionKeywordFragment<TRes>
    implements CopyWith$Fragment$SuggestionKeywordFragment<TRes> {
  _CopyWithImpl$Fragment$SuggestionKeywordFragment(this._instance, this._then);

  final Fragment$SuggestionKeywordFragment _instance;

  final TRes Function(Fragment$SuggestionKeywordFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? value = _undefined,
    Object? results = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$SuggestionKeywordFragment(
      value: value == _undefined || value == null
          ? _instance.value
          : (value as String),
      results: results == _undefined || results == null
          ? _instance.results
          : (results as int),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$SuggestionKeywordFragment<TRes>
    implements CopyWith$Fragment$SuggestionKeywordFragment<TRes> {
  _CopyWithStubImpl$Fragment$SuggestionKeywordFragment(this._res);

  TRes _res;

  call({String? value, int? results, String? $__typename}) => _res;
}

const fragmentDefinitionSuggestionKeywordFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SuggestionKeywordFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'SuggestionKeyword'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'value'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'results'),
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
const documentNodeFragmentSuggestionKeywordFragment = DocumentNode(
  definitions: [fragmentDefinitionSuggestionKeywordFragment],
);

extension ClientExtension$Fragment$SuggestionKeywordFragment
    on graphql.GraphQLClient {
  void writeFragment$SuggestionKeywordFragment({
    required Fragment$SuggestionKeywordFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SuggestionKeywordFragment',
        document: documentNodeFragmentSuggestionKeywordFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SuggestionKeywordFragment? readFragment$SuggestionKeywordFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SuggestionKeywordFragment',
          document: documentNodeFragmentSuggestionKeywordFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$SuggestionKeywordFragment.fromJson(result);
  }
}
