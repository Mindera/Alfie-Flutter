import 'money_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$PriceRangeFragment {
  Fragment$PriceRangeFragment({
    required this.low,
    this.high,
    this.$__typename = 'PriceRange',
  });

  factory Fragment$PriceRangeFragment.fromJson(Map<String, dynamic> json) {
    final l$low = json['low'];
    final l$high = json['high'];
    final l$$__typename = json['__typename'];
    return Fragment$PriceRangeFragment(
      low: Fragment$MoneyFragment.fromJson((l$low as Map<String, dynamic>)),
      high: l$high == null
          ? null
          : Fragment$MoneyFragment.fromJson((l$high as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$MoneyFragment low;

  final Fragment$MoneyFragment? high;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$low = low;
    _resultData['low'] = l$low.toJson();
    final l$high = high;
    _resultData['high'] = l$high?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$low = low;
    final l$high = high;
    final l$$__typename = $__typename;
    return Object.hashAll([l$low, l$high, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$PriceRangeFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$low = low;
    final lOther$low = other.low;
    if (l$low != lOther$low) {
      return false;
    }
    final l$high = high;
    final lOther$high = other.high;
    if (l$high != lOther$high) {
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

extension UtilityExtension$Fragment$PriceRangeFragment
    on Fragment$PriceRangeFragment {
  CopyWith$Fragment$PriceRangeFragment<Fragment$PriceRangeFragment>
  get copyWith => CopyWith$Fragment$PriceRangeFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$PriceRangeFragment<TRes> {
  factory CopyWith$Fragment$PriceRangeFragment(
    Fragment$PriceRangeFragment instance,
    TRes Function(Fragment$PriceRangeFragment) then,
  ) = _CopyWithImpl$Fragment$PriceRangeFragment;

  factory CopyWith$Fragment$PriceRangeFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$PriceRangeFragment;

  TRes call({
    Fragment$MoneyFragment? low,
    Fragment$MoneyFragment? high,
    String? $__typename,
  });
  CopyWith$Fragment$MoneyFragment<TRes> get low;
  CopyWith$Fragment$MoneyFragment<TRes> get high;
}

class _CopyWithImpl$Fragment$PriceRangeFragment<TRes>
    implements CopyWith$Fragment$PriceRangeFragment<TRes> {
  _CopyWithImpl$Fragment$PriceRangeFragment(this._instance, this._then);

  final Fragment$PriceRangeFragment _instance;

  final TRes Function(Fragment$PriceRangeFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? low = _undefined,
    Object? high = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$PriceRangeFragment(
      low: low == _undefined || low == null
          ? _instance.low
          : (low as Fragment$MoneyFragment),
      high: high == _undefined
          ? _instance.high
          : (high as Fragment$MoneyFragment?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$MoneyFragment<TRes> get low {
    final local$low = _instance.low;
    return CopyWith$Fragment$MoneyFragment(local$low, (e) => call(low: e));
  }

  CopyWith$Fragment$MoneyFragment<TRes> get high {
    final local$high = _instance.high;
    return local$high == null
        ? CopyWith$Fragment$MoneyFragment.stub(_then(_instance))
        : CopyWith$Fragment$MoneyFragment(local$high, (e) => call(high: e));
  }
}

class _CopyWithStubImpl$Fragment$PriceRangeFragment<TRes>
    implements CopyWith$Fragment$PriceRangeFragment<TRes> {
  _CopyWithStubImpl$Fragment$PriceRangeFragment(this._res);

  TRes _res;

  call({
    Fragment$MoneyFragment? low,
    Fragment$MoneyFragment? high,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$MoneyFragment<TRes> get low =>
      CopyWith$Fragment$MoneyFragment.stub(_res);

  CopyWith$Fragment$MoneyFragment<TRes> get high =>
      CopyWith$Fragment$MoneyFragment.stub(_res);
}

const fragmentDefinitionPriceRangeFragment = FragmentDefinitionNode(
  name: NameNode(value: 'PriceRangeFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'PriceRange'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'low'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'MoneyFragment'),
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
        name: NameNode(value: 'high'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'MoneyFragment'),
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
);
const documentNodeFragmentPriceRangeFragment = DocumentNode(
  definitions: [
    fragmentDefinitionPriceRangeFragment,
    fragmentDefinitionMoneyFragment,
  ],
);

extension ClientExtension$Fragment$PriceRangeFragment on graphql.GraphQLClient {
  void writeFragment$PriceRangeFragment({
    required Fragment$PriceRangeFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'PriceRangeFragment',
        document: documentNodeFragmentPriceRangeFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$PriceRangeFragment? readFragment$PriceRangeFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'PriceRangeFragment',
          document: documentNodeFragmentPriceRangeFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$PriceRangeFragment.fromJson(result);
  }
}
