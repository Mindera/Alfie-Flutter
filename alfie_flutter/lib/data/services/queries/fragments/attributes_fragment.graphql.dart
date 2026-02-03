import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$AttributesFragment {
  Fragment$AttributesFragment({
    required this.key,
    required this.value,
    this.$__typename = 'KeyValuePair',
  });

  factory Fragment$AttributesFragment.fromJson(Map<String, dynamic> json) {
    final l$key = json['key'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Fragment$AttributesFragment(
      key: (l$key as String),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String key;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$key = key;
    _resultData['key'] = l$key;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$key = key;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$key, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$AttributesFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
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

extension UtilityExtension$Fragment$AttributesFragment
    on Fragment$AttributesFragment {
  CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>
  get copyWith => CopyWith$Fragment$AttributesFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$AttributesFragment<TRes> {
  factory CopyWith$Fragment$AttributesFragment(
    Fragment$AttributesFragment instance,
    TRes Function(Fragment$AttributesFragment) then,
  ) = _CopyWithImpl$Fragment$AttributesFragment;

  factory CopyWith$Fragment$AttributesFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$AttributesFragment;

  TRes call({String? key, String? value, String? $__typename});
}

class _CopyWithImpl$Fragment$AttributesFragment<TRes>
    implements CopyWith$Fragment$AttributesFragment<TRes> {
  _CopyWithImpl$Fragment$AttributesFragment(this._instance, this._then);

  final Fragment$AttributesFragment _instance;

  final TRes Function(Fragment$AttributesFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? key = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$AttributesFragment(
      key: key == _undefined || key == null ? _instance.key : (key as String),
      value: value == _undefined || value == null
          ? _instance.value
          : (value as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$AttributesFragment<TRes>
    implements CopyWith$Fragment$AttributesFragment<TRes> {
  _CopyWithStubImpl$Fragment$AttributesFragment(this._res);

  TRes _res;

  call({String? key, String? value, String? $__typename}) => _res;
}

const fragmentDefinitionAttributesFragment = FragmentDefinitionNode(
  name: NameNode(value: 'AttributesFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'KeyValuePair'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'key'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'value'),
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
const documentNodeFragmentAttributesFragment = DocumentNode(
  definitions: [fragmentDefinitionAttributesFragment],
);

extension ClientExtension$Fragment$AttributesFragment on graphql.GraphQLClient {
  void writeFragment$AttributesFragment({
    required Fragment$AttributesFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'AttributesFragment',
        document: documentNodeFragmentAttributesFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$AttributesFragment? readFragment$AttributesFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'AttributesFragment',
          document: documentNodeFragmentAttributesFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$AttributesFragment.fromJson(result);
  }
}
