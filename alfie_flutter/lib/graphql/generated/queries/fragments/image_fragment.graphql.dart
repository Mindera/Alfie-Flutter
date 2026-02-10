import '../../schema.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$ImageFragment {
  Fragment$ImageFragment({
    this.alt,
    required this.mediaContentType,
    required this.url,
    this.$__typename = 'Image',
  });

  factory Fragment$ImageFragment.fromJson(Map<String, dynamic> json) {
    final l$alt = json['alt'];
    final l$mediaContentType = json['mediaContentType'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Fragment$ImageFragment(
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
    if (other is! Fragment$ImageFragment || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Fragment$ImageFragment on Fragment$ImageFragment {
  CopyWith$Fragment$ImageFragment<Fragment$ImageFragment> get copyWith =>
      CopyWith$Fragment$ImageFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$ImageFragment<TRes> {
  factory CopyWith$Fragment$ImageFragment(
    Fragment$ImageFragment instance,
    TRes Function(Fragment$ImageFragment) then,
  ) = _CopyWithImpl$Fragment$ImageFragment;

  factory CopyWith$Fragment$ImageFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ImageFragment;

  TRes call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$ImageFragment<TRes>
    implements CopyWith$Fragment$ImageFragment<TRes> {
  _CopyWithImpl$Fragment$ImageFragment(this._instance, this._then);

  final Fragment$ImageFragment _instance;

  final TRes Function(Fragment$ImageFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? alt = _undefined,
    Object? mediaContentType = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$ImageFragment(
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

class _CopyWithStubImpl$Fragment$ImageFragment<TRes>
    implements CopyWith$Fragment$ImageFragment<TRes> {
  _CopyWithStubImpl$Fragment$ImageFragment(this._res);

  TRes _res;

  call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionImageFragment = FragmentDefinitionNode(
  name: NameNode(value: 'ImageFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Image'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'alt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'mediaContentType'),
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
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentImageFragment = DocumentNode(
  definitions: [fragmentDefinitionImageFragment],
);

extension ClientExtension$Fragment$ImageFragment on graphql.GraphQLClient {
  void writeFragment$ImageFragment({
    required Fragment$ImageFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'ImageFragment',
        document: documentNodeFragmentImageFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$ImageFragment? readFragment$ImageFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'ImageFragment',
          document: documentNodeFragmentImageFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$ImageFragment.fromJson(result);
  }
}
