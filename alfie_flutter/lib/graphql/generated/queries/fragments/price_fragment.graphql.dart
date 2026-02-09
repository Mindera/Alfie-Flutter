import 'money_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$PriceFragment {
  Fragment$PriceFragment({
    required this.amount,
    this.was,
    this.$__typename = 'Price',
  });

  factory Fragment$PriceFragment.fromJson(Map<String, dynamic> json) {
    final l$amount = json['amount'];
    final l$was = json['was'];
    final l$$__typename = json['__typename'];
    return Fragment$PriceFragment(
      amount: Fragment$MoneyFragment.fromJson(
        (l$amount as Map<String, dynamic>),
      ),
      was: l$was == null
          ? null
          : Fragment$MoneyFragment.fromJson((l$was as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$MoneyFragment amount;

  final Fragment$MoneyFragment? was;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$amount = amount;
    _resultData['amount'] = l$amount.toJson();
    final l$was = was;
    _resultData['was'] = l$was?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$amount = amount;
    final l$was = was;
    final l$$__typename = $__typename;
    return Object.hashAll([l$amount, l$was, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$PriceFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$was = was;
    final lOther$was = other.was;
    if (l$was != lOther$was) {
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

extension UtilityExtension$Fragment$PriceFragment on Fragment$PriceFragment {
  CopyWith$Fragment$PriceFragment<Fragment$PriceFragment> get copyWith =>
      CopyWith$Fragment$PriceFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$PriceFragment<TRes> {
  factory CopyWith$Fragment$PriceFragment(
    Fragment$PriceFragment instance,
    TRes Function(Fragment$PriceFragment) then,
  ) = _CopyWithImpl$Fragment$PriceFragment;

  factory CopyWith$Fragment$PriceFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$PriceFragment;

  TRes call({
    Fragment$MoneyFragment? amount,
    Fragment$MoneyFragment? was,
    String? $__typename,
  });
  CopyWith$Fragment$MoneyFragment<TRes> get amount;
  CopyWith$Fragment$MoneyFragment<TRes> get was;
}

class _CopyWithImpl$Fragment$PriceFragment<TRes>
    implements CopyWith$Fragment$PriceFragment<TRes> {
  _CopyWithImpl$Fragment$PriceFragment(this._instance, this._then);

  final Fragment$PriceFragment _instance;

  final TRes Function(Fragment$PriceFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? amount = _undefined,
    Object? was = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$PriceFragment(
      amount: amount == _undefined || amount == null
          ? _instance.amount
          : (amount as Fragment$MoneyFragment),
      was: was == _undefined ? _instance.was : (was as Fragment$MoneyFragment?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$MoneyFragment<TRes> get amount {
    final local$amount = _instance.amount;
    return CopyWith$Fragment$MoneyFragment(
      local$amount,
      (e) => call(amount: e),
    );
  }

  CopyWith$Fragment$MoneyFragment<TRes> get was {
    final local$was = _instance.was;
    return local$was == null
        ? CopyWith$Fragment$MoneyFragment.stub(_then(_instance))
        : CopyWith$Fragment$MoneyFragment(local$was, (e) => call(was: e));
  }
}

class _CopyWithStubImpl$Fragment$PriceFragment<TRes>
    implements CopyWith$Fragment$PriceFragment<TRes> {
  _CopyWithStubImpl$Fragment$PriceFragment(this._res);

  TRes _res;

  call({
    Fragment$MoneyFragment? amount,
    Fragment$MoneyFragment? was,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$MoneyFragment<TRes> get amount =>
      CopyWith$Fragment$MoneyFragment.stub(_res);

  CopyWith$Fragment$MoneyFragment<TRes> get was =>
      CopyWith$Fragment$MoneyFragment.stub(_res);
}

const fragmentDefinitionPriceFragment = FragmentDefinitionNode(
  name: NameNode(value: 'PriceFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Price'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'amount'),
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
        name: NameNode(value: 'was'),
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
const documentNodeFragmentPriceFragment = DocumentNode(
  definitions: [
    fragmentDefinitionPriceFragment,
    fragmentDefinitionMoneyFragment,
  ],
);

extension ClientExtension$Fragment$PriceFragment on graphql.GraphQLClient {
  void writeFragment$PriceFragment({
    required Fragment$PriceFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'PriceFragment',
        document: documentNodeFragmentPriceFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$PriceFragment? readFragment$PriceFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'PriceFragment',
          document: documentNodeFragmentPriceFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$PriceFragment.fromJson(result);
  }
}
