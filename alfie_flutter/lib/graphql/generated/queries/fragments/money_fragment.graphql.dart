import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$MoneyFragment {
  Fragment$MoneyFragment({
    required this.currencyCode,
    required this.amount,
    required this.amountFormatted,
    this.$__typename = 'Money',
  });

  factory Fragment$MoneyFragment.fromJson(Map<String, dynamic> json) {
    final l$currencyCode = json['currencyCode'];
    final l$amount = json['amount'];
    final l$amountFormatted = json['amountFormatted'];
    final l$$__typename = json['__typename'];
    return Fragment$MoneyFragment(
      currencyCode: (l$currencyCode as String),
      amount: (l$amount as int),
      amountFormatted: (l$amountFormatted as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String currencyCode;

  final int amount;

  final String amountFormatted;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$currencyCode = currencyCode;
    _resultData['currencyCode'] = l$currencyCode;
    final l$amount = amount;
    _resultData['amount'] = l$amount;
    final l$amountFormatted = amountFormatted;
    _resultData['amountFormatted'] = l$amountFormatted;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$currencyCode = currencyCode;
    final l$amount = amount;
    final l$amountFormatted = amountFormatted;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$currencyCode,
      l$amount,
      l$amountFormatted,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MoneyFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$currencyCode = currencyCode;
    final lOther$currencyCode = other.currencyCode;
    if (l$currencyCode != lOther$currencyCode) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$amountFormatted = amountFormatted;
    final lOther$amountFormatted = other.amountFormatted;
    if (l$amountFormatted != lOther$amountFormatted) {
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

extension UtilityExtension$Fragment$MoneyFragment on Fragment$MoneyFragment {
  CopyWith$Fragment$MoneyFragment<Fragment$MoneyFragment> get copyWith =>
      CopyWith$Fragment$MoneyFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$MoneyFragment<TRes> {
  factory CopyWith$Fragment$MoneyFragment(
    Fragment$MoneyFragment instance,
    TRes Function(Fragment$MoneyFragment) then,
  ) = _CopyWithImpl$Fragment$MoneyFragment;

  factory CopyWith$Fragment$MoneyFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MoneyFragment;

  TRes call({
    String? currencyCode,
    int? amount,
    String? amountFormatted,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$MoneyFragment<TRes>
    implements CopyWith$Fragment$MoneyFragment<TRes> {
  _CopyWithImpl$Fragment$MoneyFragment(this._instance, this._then);

  final Fragment$MoneyFragment _instance;

  final TRes Function(Fragment$MoneyFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? currencyCode = _undefined,
    Object? amount = _undefined,
    Object? amountFormatted = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MoneyFragment(
      currencyCode: currencyCode == _undefined || currencyCode == null
          ? _instance.currencyCode
          : (currencyCode as String),
      amount: amount == _undefined || amount == null
          ? _instance.amount
          : (amount as int),
      amountFormatted: amountFormatted == _undefined || amountFormatted == null
          ? _instance.amountFormatted
          : (amountFormatted as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MoneyFragment<TRes>
    implements CopyWith$Fragment$MoneyFragment<TRes> {
  _CopyWithStubImpl$Fragment$MoneyFragment(this._res);

  TRes _res;

  call({
    String? currencyCode,
    int? amount,
    String? amountFormatted,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionMoneyFragment = FragmentDefinitionNode(
  name: NameNode(value: 'MoneyFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Money'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'currencyCode'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'amount'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'amountFormatted'),
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
const documentNodeFragmentMoneyFragment = DocumentNode(
  definitions: [fragmentDefinitionMoneyFragment],
);

extension ClientExtension$Fragment$MoneyFragment on graphql.GraphQLClient {
  void writeFragment$MoneyFragment({
    required Fragment$MoneyFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'MoneyFragment',
        document: documentNodeFragmentMoneyFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$MoneyFragment? readFragment$MoneyFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'MoneyFragment',
          document: documentNodeFragmentMoneyFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$MoneyFragment.fromJson(result);
  }
}
