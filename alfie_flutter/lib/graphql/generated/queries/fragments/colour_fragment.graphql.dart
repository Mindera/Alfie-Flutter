import 'media_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$ColourFragment {
  Fragment$ColourFragment({
    required this.id,
    required this.name,
    this.swatch,
    this.media,
    this.$__typename = 'Colour',
  });

  factory Fragment$ColourFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$swatch = json['swatch'];
    final l$media = json['media'];
    final l$$__typename = json['__typename'];
    return Fragment$ColourFragment(
      id: (l$id as String),
      name: (l$name as String),
      swatch: l$swatch == null
          ? null
          : Fragment$ImageFragment.fromJson((l$swatch as Map<String, dynamic>)),
      media: (l$media as List<dynamic>?)
          ?.map(
            (e) => Fragment$MediaFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final Fragment$ImageFragment? swatch;

  final List<Fragment$MediaFragment>? media;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$swatch = swatch;
    _resultData['swatch'] = l$swatch?.toJson();
    final l$media = media;
    _resultData['media'] = l$media?.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$swatch = swatch;
    final l$media = media;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$swatch,
      l$media == null ? null : Object.hashAll(l$media.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ColourFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$swatch = swatch;
    final lOther$swatch = other.swatch;
    if (l$swatch != lOther$swatch) {
      return false;
    }
    final l$media = media;
    final lOther$media = other.media;
    if (l$media != null && lOther$media != null) {
      if (l$media.length != lOther$media.length) {
        return false;
      }
      for (int i = 0; i < l$media.length; i++) {
        final l$media$entry = l$media[i];
        final lOther$media$entry = lOther$media[i];
        if (l$media$entry != lOther$media$entry) {
          return false;
        }
      }
    } else if (l$media != lOther$media) {
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

extension UtilityExtension$Fragment$ColourFragment on Fragment$ColourFragment {
  CopyWith$Fragment$ColourFragment<Fragment$ColourFragment> get copyWith =>
      CopyWith$Fragment$ColourFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$ColourFragment<TRes> {
  factory CopyWith$Fragment$ColourFragment(
    Fragment$ColourFragment instance,
    TRes Function(Fragment$ColourFragment) then,
  ) = _CopyWithImpl$Fragment$ColourFragment;

  factory CopyWith$Fragment$ColourFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ColourFragment;

  TRes call({
    String? id,
    String? name,
    Fragment$ImageFragment? swatch,
    List<Fragment$MediaFragment>? media,
    String? $__typename,
  });
  CopyWith$Fragment$ImageFragment<TRes> get swatch;
  TRes media(
    Iterable<Fragment$MediaFragment>? Function(
      Iterable<CopyWith$Fragment$MediaFragment<Fragment$MediaFragment>>?,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$ColourFragment<TRes>
    implements CopyWith$Fragment$ColourFragment<TRes> {
  _CopyWithImpl$Fragment$ColourFragment(this._instance, this._then);

  final Fragment$ColourFragment _instance;

  final TRes Function(Fragment$ColourFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? swatch = _undefined,
    Object? media = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$ColourFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      swatch: swatch == _undefined
          ? _instance.swatch
          : (swatch as Fragment$ImageFragment?),
      media: media == _undefined
          ? _instance.media
          : (media as List<Fragment$MediaFragment>?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$ImageFragment<TRes> get swatch {
    final local$swatch = _instance.swatch;
    return local$swatch == null
        ? CopyWith$Fragment$ImageFragment.stub(_then(_instance))
        : CopyWith$Fragment$ImageFragment(local$swatch, (e) => call(swatch: e));
  }

  TRes media(
    Iterable<Fragment$MediaFragment>? Function(
      Iterable<CopyWith$Fragment$MediaFragment<Fragment$MediaFragment>>?,
    )
    _fn,
  ) => call(
    media: _fn(
      _instance.media?.map((e) => CopyWith$Fragment$MediaFragment(e, (i) => i)),
    )?.toList(),
  );
}

class _CopyWithStubImpl$Fragment$ColourFragment<TRes>
    implements CopyWith$Fragment$ColourFragment<TRes> {
  _CopyWithStubImpl$Fragment$ColourFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    Fragment$ImageFragment? swatch,
    List<Fragment$MediaFragment>? media,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$ImageFragment<TRes> get swatch =>
      CopyWith$Fragment$ImageFragment.stub(_res);

  media(_fn) => _res;
}

const fragmentDefinitionColourFragment = FragmentDefinitionNode(
  name: NameNode(value: 'ColourFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Colour'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'swatch'),
        alias: null,
        arguments: [],
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
        name: NameNode(value: 'media'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'MediaFragment'),
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
const documentNodeFragmentColourFragment = DocumentNode(
  definitions: [
    fragmentDefinitionColourFragment,
    fragmentDefinitionImageFragment,
    fragmentDefinitionMediaFragment,
  ],
);

extension ClientExtension$Fragment$ColourFragment on graphql.GraphQLClient {
  void writeFragment$ColourFragment({
    required Fragment$ColourFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'ColourFragment',
        document: documentNodeFragmentColourFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$ColourFragment? readFragment$ColourFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'ColourFragment',
          document: documentNodeFragmentColourFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$ColourFragment.fromJson(result);
  }
}
