import '../../../schema.graphql.dart';
import '../../fragments/attributes_fragment.graphql.dart';
import '../../fragments/media_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$NavMenuItemFragment {
  Fragment$NavMenuItemFragment({
    required this.title,
    required this.type,
    this.url,
    this.media,
    this.attributes,
    this.$__typename = 'NavMenuItem',
  });

  factory Fragment$NavMenuItemFragment.fromJson(Map<String, dynamic> json) {
    final l$title = json['title'];
    final l$type = json['type'];
    final l$url = json['url'];
    final l$media = json['media'];
    final l$attributes = json['attributes'];
    final l$$__typename = json['__typename'];
    return Fragment$NavMenuItemFragment(
      title: (l$title as String),
      type: fromJson$Enum$NavMenuItemType((l$type as String)),
      url: (l$url as String?),
      media: l$media == null
          ? null
          : Fragment$NavMenuItemFragment$media.fromJson(
              (l$media as Map<String, dynamic>),
            ),
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

  final Fragment$NavMenuItemFragment$media? media;

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
    final l$attributes = attributes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$title,
      l$type,
      l$url,
      l$media,
      l$attributes == null ? null : Object.hashAll(l$attributes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$NavMenuItemFragment ||
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

extension UtilityExtension$Fragment$NavMenuItemFragment
    on Fragment$NavMenuItemFragment {
  CopyWith$Fragment$NavMenuItemFragment<Fragment$NavMenuItemFragment>
  get copyWith => CopyWith$Fragment$NavMenuItemFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$NavMenuItemFragment<TRes> {
  factory CopyWith$Fragment$NavMenuItemFragment(
    Fragment$NavMenuItemFragment instance,
    TRes Function(Fragment$NavMenuItemFragment) then,
  ) = _CopyWithImpl$Fragment$NavMenuItemFragment;

  factory CopyWith$Fragment$NavMenuItemFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$NavMenuItemFragment;

  TRes call({
    String? title,
    Enum$NavMenuItemType? type,
    String? url,
    Fragment$NavMenuItemFragment$media? media,
    List<Fragment$AttributesFragment?>? attributes,
    String? $__typename,
  });
  CopyWith$Fragment$NavMenuItemFragment$media<TRes> get media;
  TRes attributes(
    Iterable<Fragment$AttributesFragment?>? Function(
      Iterable<
        CopyWith$Fragment$AttributesFragment<Fragment$AttributesFragment>?
      >?,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$NavMenuItemFragment<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment<TRes> {
  _CopyWithImpl$Fragment$NavMenuItemFragment(this._instance, this._then);

  final Fragment$NavMenuItemFragment _instance;

  final TRes Function(Fragment$NavMenuItemFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? type = _undefined,
    Object? url = _undefined,
    Object? media = _undefined,
    Object? attributes = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$NavMenuItemFragment(
      title: title == _undefined || title == null
          ? _instance.title
          : (title as String),
      type: type == _undefined || type == null
          ? _instance.type
          : (type as Enum$NavMenuItemType),
      url: url == _undefined ? _instance.url : (url as String?),
      media: media == _undefined
          ? _instance.media
          : (media as Fragment$NavMenuItemFragment$media?),
      attributes: attributes == _undefined
          ? _instance.attributes
          : (attributes as List<Fragment$AttributesFragment?>?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$NavMenuItemFragment$media<TRes> get media {
    final local$media = _instance.media;
    return local$media == null
        ? CopyWith$Fragment$NavMenuItemFragment$media.stub(_then(_instance))
        : CopyWith$Fragment$NavMenuItemFragment$media(
            local$media,
            (e) => call(media: e),
          );
  }

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

class _CopyWithStubImpl$Fragment$NavMenuItemFragment<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment<TRes> {
  _CopyWithStubImpl$Fragment$NavMenuItemFragment(this._res);

  TRes _res;

  call({
    String? title,
    Enum$NavMenuItemType? type,
    String? url,
    Fragment$NavMenuItemFragment$media? media,
    List<Fragment$AttributesFragment?>? attributes,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$NavMenuItemFragment$media<TRes> get media =>
      CopyWith$Fragment$NavMenuItemFragment$media.stub(_res);

  attributes(_fn) => _res;
}

const fragmentDefinitionNavMenuItemFragment = FragmentDefinitionNode(
  name: NameNode(value: 'NavMenuItemFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'NavMenuItem'), isNonNull: false),
  ),
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
        directives: [],
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
);
const documentNodeFragmentNavMenuItemFragment = DocumentNode(
  definitions: [
    fragmentDefinitionNavMenuItemFragment,
    fragmentDefinitionImageFragment,
    fragmentDefinitionAttributesFragment,
  ],
);

extension ClientExtension$Fragment$NavMenuItemFragment
    on graphql.GraphQLClient {
  void writeFragment$NavMenuItemFragment({
    required Fragment$NavMenuItemFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'NavMenuItemFragment',
        document: documentNodeFragmentNavMenuItemFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$NavMenuItemFragment? readFragment$NavMenuItemFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'NavMenuItemFragment',
          document: documentNodeFragmentNavMenuItemFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$NavMenuItemFragment.fromJson(result);
  }
}

class Fragment$NavMenuItemFragment$media {
  Fragment$NavMenuItemFragment$media({required this.$__typename});

  factory Fragment$NavMenuItemFragment$media.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "Image":
        return Fragment$NavMenuItemFragment$media$$Image.fromJson(json);

      case "Video":
        return Fragment$NavMenuItemFragment$media$$Video.fromJson(json);

      default:
        final l$$__typename = json['__typename'];
        return Fragment$NavMenuItemFragment$media(
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
    if (other is! Fragment$NavMenuItemFragment$media ||
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

extension UtilityExtension$Fragment$NavMenuItemFragment$media
    on Fragment$NavMenuItemFragment$media {
  CopyWith$Fragment$NavMenuItemFragment$media<
    Fragment$NavMenuItemFragment$media
  >
  get copyWith => CopyWith$Fragment$NavMenuItemFragment$media(this, (i) => i);

  _T when<_T>({
    required _T Function(Fragment$NavMenuItemFragment$media$$Image) image,
    required _T Function(Fragment$NavMenuItemFragment$media$$Video) video,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "Image":
        return image(this as Fragment$NavMenuItemFragment$media$$Image);

      case "Video":
        return video(this as Fragment$NavMenuItemFragment$media$$Video);

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(Fragment$NavMenuItemFragment$media$$Image)? image,
    _T Function(Fragment$NavMenuItemFragment$media$$Video)? video,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "Image":
        if (image != null) {
          return image(this as Fragment$NavMenuItemFragment$media$$Image);
        } else {
          return orElse();
        }

      case "Video":
        if (video != null) {
          return video(this as Fragment$NavMenuItemFragment$media$$Video);
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Fragment$NavMenuItemFragment$media<TRes> {
  factory CopyWith$Fragment$NavMenuItemFragment$media(
    Fragment$NavMenuItemFragment$media instance,
    TRes Function(Fragment$NavMenuItemFragment$media) then,
  ) = _CopyWithImpl$Fragment$NavMenuItemFragment$media;

  factory CopyWith$Fragment$NavMenuItemFragment$media.stub(TRes res) =
      _CopyWithStubImpl$Fragment$NavMenuItemFragment$media;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Fragment$NavMenuItemFragment$media<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment$media<TRes> {
  _CopyWithImpl$Fragment$NavMenuItemFragment$media(this._instance, this._then);

  final Fragment$NavMenuItemFragment$media _instance;

  final TRes Function(Fragment$NavMenuItemFragment$media) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Fragment$NavMenuItemFragment$media(
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$NavMenuItemFragment$media<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment$media<TRes> {
  _CopyWithStubImpl$Fragment$NavMenuItemFragment$media(this._res);

  TRes _res;

  call({String? $__typename}) => _res;
}

class Fragment$NavMenuItemFragment$media$$Image
    implements Fragment$ImageFragment, Fragment$NavMenuItemFragment$media {
  Fragment$NavMenuItemFragment$media$$Image({
    this.alt,
    required this.mediaContentType,
    required this.url,
    this.$__typename = 'Image',
  });

  factory Fragment$NavMenuItemFragment$media$$Image.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$alt = json['alt'];
    final l$mediaContentType = json['mediaContentType'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Fragment$NavMenuItemFragment$media$$Image(
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
    if (other is! Fragment$NavMenuItemFragment$media$$Image ||
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

extension UtilityExtension$Fragment$NavMenuItemFragment$media$$Image
    on Fragment$NavMenuItemFragment$media$$Image {
  CopyWith$Fragment$NavMenuItemFragment$media$$Image<
    Fragment$NavMenuItemFragment$media$$Image
  >
  get copyWith =>
      CopyWith$Fragment$NavMenuItemFragment$media$$Image(this, (i) => i);
}

abstract class CopyWith$Fragment$NavMenuItemFragment$media$$Image<TRes> {
  factory CopyWith$Fragment$NavMenuItemFragment$media$$Image(
    Fragment$NavMenuItemFragment$media$$Image instance,
    TRes Function(Fragment$NavMenuItemFragment$media$$Image) then,
  ) = _CopyWithImpl$Fragment$NavMenuItemFragment$media$$Image;

  factory CopyWith$Fragment$NavMenuItemFragment$media$$Image.stub(TRes res) =
      _CopyWithStubImpl$Fragment$NavMenuItemFragment$media$$Image;

  TRes call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$NavMenuItemFragment$media$$Image<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment$media$$Image<TRes> {
  _CopyWithImpl$Fragment$NavMenuItemFragment$media$$Image(
    this._instance,
    this._then,
  );

  final Fragment$NavMenuItemFragment$media$$Image _instance;

  final TRes Function(Fragment$NavMenuItemFragment$media$$Image) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? alt = _undefined,
    Object? mediaContentType = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$NavMenuItemFragment$media$$Image(
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

class _CopyWithStubImpl$Fragment$NavMenuItemFragment$media$$Image<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment$media$$Image<TRes> {
  _CopyWithStubImpl$Fragment$NavMenuItemFragment$media$$Image(this._res);

  TRes _res;

  call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  }) => _res;
}

class Fragment$NavMenuItemFragment$media$$Video
    implements Fragment$NavMenuItemFragment$media {
  Fragment$NavMenuItemFragment$media$$Video({this.$__typename = 'Video'});

  factory Fragment$NavMenuItemFragment$media$$Video.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$$__typename = json['__typename'];
    return Fragment$NavMenuItemFragment$media$$Video(
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
    if (other is! Fragment$NavMenuItemFragment$media$$Video ||
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

extension UtilityExtension$Fragment$NavMenuItemFragment$media$$Video
    on Fragment$NavMenuItemFragment$media$$Video {
  CopyWith$Fragment$NavMenuItemFragment$media$$Video<
    Fragment$NavMenuItemFragment$media$$Video
  >
  get copyWith =>
      CopyWith$Fragment$NavMenuItemFragment$media$$Video(this, (i) => i);
}

abstract class CopyWith$Fragment$NavMenuItemFragment$media$$Video<TRes> {
  factory CopyWith$Fragment$NavMenuItemFragment$media$$Video(
    Fragment$NavMenuItemFragment$media$$Video instance,
    TRes Function(Fragment$NavMenuItemFragment$media$$Video) then,
  ) = _CopyWithImpl$Fragment$NavMenuItemFragment$media$$Video;

  factory CopyWith$Fragment$NavMenuItemFragment$media$$Video.stub(TRes res) =
      _CopyWithStubImpl$Fragment$NavMenuItemFragment$media$$Video;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Fragment$NavMenuItemFragment$media$$Video<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment$media$$Video<TRes> {
  _CopyWithImpl$Fragment$NavMenuItemFragment$media$$Video(
    this._instance,
    this._then,
  );

  final Fragment$NavMenuItemFragment$media$$Video _instance;

  final TRes Function(Fragment$NavMenuItemFragment$media$$Video) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Fragment$NavMenuItemFragment$media$$Video(
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$NavMenuItemFragment$media$$Video<TRes>
    implements CopyWith$Fragment$NavMenuItemFragment$media$$Video<TRes> {
  _CopyWithStubImpl$Fragment$NavMenuItemFragment$media$$Video(this._res);

  TRes _res;

  call({String? $__typename}) => _res;
}
