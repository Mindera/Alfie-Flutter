import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$SuggestionBrandFragment {
  Fragment$SuggestionBrandFragment({
    required this.value,
    required this.results,
    this.$__typename = 'SuggestionBrand',
  });

  factory Fragment$SuggestionBrandFragment.fromJson(Map<String, dynamic> json) {
    final l$value = json['value'];
    final l$results = json['results'];
    final l$$__typename = json['__typename'];
    return Fragment$SuggestionBrandFragment(
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
    if (other is! Fragment$SuggestionBrandFragment ||
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

extension UtilityExtension$Fragment$SuggestionBrandFragment
    on Fragment$SuggestionBrandFragment {
  CopyWith$Fragment$SuggestionBrandFragment<Fragment$SuggestionBrandFragment>
  get copyWith => CopyWith$Fragment$SuggestionBrandFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SuggestionBrandFragment<TRes> {
  factory CopyWith$Fragment$SuggestionBrandFragment(
    Fragment$SuggestionBrandFragment instance,
    TRes Function(Fragment$SuggestionBrandFragment) then,
  ) = _CopyWithImpl$Fragment$SuggestionBrandFragment;

  factory CopyWith$Fragment$SuggestionBrandFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SuggestionBrandFragment;

  TRes call({String? value, int? results, String? $__typename});
}

class _CopyWithImpl$Fragment$SuggestionBrandFragment<TRes>
    implements CopyWith$Fragment$SuggestionBrandFragment<TRes> {
  _CopyWithImpl$Fragment$SuggestionBrandFragment(this._instance, this._then);

  final Fragment$SuggestionBrandFragment _instance;

  final TRes Function(Fragment$SuggestionBrandFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? value = _undefined,
    Object? results = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$SuggestionBrandFragment(
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

class _CopyWithStubImpl$Fragment$SuggestionBrandFragment<TRes>
    implements CopyWith$Fragment$SuggestionBrandFragment<TRes> {
  _CopyWithStubImpl$Fragment$SuggestionBrandFragment(this._res);

  TRes _res;

  call({String? value, int? results, String? $__typename}) => _res;
}

const fragmentDefinitionSuggestionBrandFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SuggestionBrandFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'SuggestionBrand'),
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
const documentNodeFragmentSuggestionBrandFragment = DocumentNode(
  definitions: [fragmentDefinitionSuggestionBrandFragment],
);

extension ClientExtension$Fragment$SuggestionBrandFragment
    on graphql.GraphQLClient {
  void writeFragment$SuggestionBrandFragment({
    required Fragment$SuggestionBrandFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SuggestionBrandFragment',
        document: documentNodeFragmentSuggestionBrandFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SuggestionBrandFragment? readFragment$SuggestionBrandFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SuggestionBrandFragment',
          document: documentNodeFragmentSuggestionBrandFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$SuggestionBrandFragment.fromJson(result);
  }
}
