import '../../schema.graphql.dart';
import 'image_fragment.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$MediaFragment {
  Fragment$MediaFragment({required this.$__typename});

  factory Fragment$MediaFragment.fromJson(Map<String, dynamic> json) {
    switch (json["__typename"] as String) {
      case "Image":
        return Fragment$MediaFragment$$Image.fromJson(json);

      case "Video":
        return Fragment$MediaFragment$$Video.fromJson(json);

      default:
        final l$$__typename = json['__typename'];
        return Fragment$MediaFragment($__typename: (l$$__typename as String));
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
    if (other is! Fragment$MediaFragment || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Fragment$MediaFragment on Fragment$MediaFragment {
  CopyWith$Fragment$MediaFragment<Fragment$MediaFragment> get copyWith =>
      CopyWith$Fragment$MediaFragment(this, (i) => i);

  _T when<_T>({
    required _T Function(Fragment$MediaFragment$$Image) image,
    required _T Function(Fragment$MediaFragment$$Video) video,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "Image":
        return image(this as Fragment$MediaFragment$$Image);

      case "Video":
        return video(this as Fragment$MediaFragment$$Video);

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(Fragment$MediaFragment$$Image)? image,
    _T Function(Fragment$MediaFragment$$Video)? video,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "Image":
        if (image != null) {
          return image(this as Fragment$MediaFragment$$Image);
        } else {
          return orElse();
        }

      case "Video":
        if (video != null) {
          return video(this as Fragment$MediaFragment$$Video);
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Fragment$MediaFragment<TRes> {
  factory CopyWith$Fragment$MediaFragment(
    Fragment$MediaFragment instance,
    TRes Function(Fragment$MediaFragment) then,
  ) = _CopyWithImpl$Fragment$MediaFragment;

  factory CopyWith$Fragment$MediaFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MediaFragment;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Fragment$MediaFragment<TRes>
    implements CopyWith$Fragment$MediaFragment<TRes> {
  _CopyWithImpl$Fragment$MediaFragment(this._instance, this._then);

  final Fragment$MediaFragment _instance;

  final TRes Function(Fragment$MediaFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Fragment$MediaFragment(
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MediaFragment<TRes>
    implements CopyWith$Fragment$MediaFragment<TRes> {
  _CopyWithStubImpl$Fragment$MediaFragment(this._res);

  TRes _res;

  call({String? $__typename}) => _res;
}

const fragmentDefinitionMediaFragment = FragmentDefinitionNode(
  name: NameNode(value: 'MediaFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Media'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      InlineFragmentNode(
        typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Image'), isNonNull: false),
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
      InlineFragmentNode(
        typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Video'), isNonNull: false),
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
              name: NameNode(value: 'sources'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(
                selections: [
                  FieldNode(
                    name: NameNode(value: 'format'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'mimeType'),
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
            ),
            FieldNode(
              name: NameNode(value: 'previewImage'),
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
const documentNodeFragmentMediaFragment = DocumentNode(
  definitions: [
    fragmentDefinitionMediaFragment,
    fragmentDefinitionImageFragment,
  ],
);

extension ClientExtension$Fragment$MediaFragment on graphql.GraphQLClient {
  void writeFragment$MediaFragment({
    required Fragment$MediaFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'MediaFragment',
        document: documentNodeFragmentMediaFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$MediaFragment? readFragment$MediaFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'MediaFragment',
          document: documentNodeFragmentMediaFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$MediaFragment.fromJson(result);
  }
}

class Fragment$MediaFragment$$Image
    implements Fragment$ImageFragment, Fragment$MediaFragment {
  Fragment$MediaFragment$$Image({
    this.alt,
    required this.mediaContentType,
    required this.url,
    this.$__typename = 'Image',
  });

  factory Fragment$MediaFragment$$Image.fromJson(Map<String, dynamic> json) {
    final l$alt = json['alt'];
    final l$mediaContentType = json['mediaContentType'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Fragment$MediaFragment$$Image(
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
    if (other is! Fragment$MediaFragment$$Image ||
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

extension UtilityExtension$Fragment$MediaFragment$$Image
    on Fragment$MediaFragment$$Image {
  CopyWith$Fragment$MediaFragment$$Image<Fragment$MediaFragment$$Image>
  get copyWith => CopyWith$Fragment$MediaFragment$$Image(this, (i) => i);
}

abstract class CopyWith$Fragment$MediaFragment$$Image<TRes> {
  factory CopyWith$Fragment$MediaFragment$$Image(
    Fragment$MediaFragment$$Image instance,
    TRes Function(Fragment$MediaFragment$$Image) then,
  ) = _CopyWithImpl$Fragment$MediaFragment$$Image;

  factory CopyWith$Fragment$MediaFragment$$Image.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MediaFragment$$Image;

  TRes call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$MediaFragment$$Image<TRes>
    implements CopyWith$Fragment$MediaFragment$$Image<TRes> {
  _CopyWithImpl$Fragment$MediaFragment$$Image(this._instance, this._then);

  final Fragment$MediaFragment$$Image _instance;

  final TRes Function(Fragment$MediaFragment$$Image) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? alt = _undefined,
    Object? mediaContentType = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MediaFragment$$Image(
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

class _CopyWithStubImpl$Fragment$MediaFragment$$Image<TRes>
    implements CopyWith$Fragment$MediaFragment$$Image<TRes> {
  _CopyWithStubImpl$Fragment$MediaFragment$$Image(this._res);

  TRes _res;

  call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    String? url,
    String? $__typename,
  }) => _res;
}

class Fragment$MediaFragment$$Video implements Fragment$MediaFragment {
  Fragment$MediaFragment$$Video({
    this.alt,
    required this.mediaContentType,
    required this.sources,
    this.previewImage,
    this.$__typename = 'Video',
  });

  factory Fragment$MediaFragment$$Video.fromJson(Map<String, dynamic> json) {
    final l$alt = json['alt'];
    final l$mediaContentType = json['mediaContentType'];
    final l$sources = json['sources'];
    final l$previewImage = json['previewImage'];
    final l$$__typename = json['__typename'];
    return Fragment$MediaFragment$$Video(
      alt: (l$alt as String?),
      mediaContentType: fromJson$Enum$MediaContentType(
        (l$mediaContentType as String),
      ),
      sources: (l$sources as List<dynamic>)
          .map(
            (e) => Fragment$MediaFragment$$Video$sources.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      previewImage: l$previewImage == null
          ? null
          : Fragment$ImageFragment.fromJson(
              (l$previewImage as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final String? alt;

  final Enum$MediaContentType mediaContentType;

  final List<Fragment$MediaFragment$$Video$sources> sources;

  final Fragment$ImageFragment? previewImage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$alt = alt;
    _resultData['alt'] = l$alt;
    final l$mediaContentType = mediaContentType;
    _resultData['mediaContentType'] = toJson$Enum$MediaContentType(
      l$mediaContentType,
    );
    final l$sources = sources;
    _resultData['sources'] = l$sources.map((e) => e.toJson()).toList();
    final l$previewImage = previewImage;
    _resultData['previewImage'] = l$previewImage?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$alt = alt;
    final l$mediaContentType = mediaContentType;
    final l$sources = sources;
    final l$previewImage = previewImage;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$alt,
      l$mediaContentType,
      Object.hashAll(l$sources.map((v) => v)),
      l$previewImage,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MediaFragment$$Video ||
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
    final l$sources = sources;
    final lOther$sources = other.sources;
    if (l$sources.length != lOther$sources.length) {
      return false;
    }
    for (int i = 0; i < l$sources.length; i++) {
      final l$sources$entry = l$sources[i];
      final lOther$sources$entry = lOther$sources[i];
      if (l$sources$entry != lOther$sources$entry) {
        return false;
      }
    }
    final l$previewImage = previewImage;
    final lOther$previewImage = other.previewImage;
    if (l$previewImage != lOther$previewImage) {
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

extension UtilityExtension$Fragment$MediaFragment$$Video
    on Fragment$MediaFragment$$Video {
  CopyWith$Fragment$MediaFragment$$Video<Fragment$MediaFragment$$Video>
  get copyWith => CopyWith$Fragment$MediaFragment$$Video(this, (i) => i);
}

abstract class CopyWith$Fragment$MediaFragment$$Video<TRes> {
  factory CopyWith$Fragment$MediaFragment$$Video(
    Fragment$MediaFragment$$Video instance,
    TRes Function(Fragment$MediaFragment$$Video) then,
  ) = _CopyWithImpl$Fragment$MediaFragment$$Video;

  factory CopyWith$Fragment$MediaFragment$$Video.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MediaFragment$$Video;

  TRes call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    List<Fragment$MediaFragment$$Video$sources>? sources,
    Fragment$ImageFragment? previewImage,
    String? $__typename,
  });
  TRes sources(
    Iterable<Fragment$MediaFragment$$Video$sources> Function(
      Iterable<
        CopyWith$Fragment$MediaFragment$$Video$sources<
          Fragment$MediaFragment$$Video$sources
        >
      >,
    )
    _fn,
  );
  CopyWith$Fragment$ImageFragment<TRes> get previewImage;
}

class _CopyWithImpl$Fragment$MediaFragment$$Video<TRes>
    implements CopyWith$Fragment$MediaFragment$$Video<TRes> {
  _CopyWithImpl$Fragment$MediaFragment$$Video(this._instance, this._then);

  final Fragment$MediaFragment$$Video _instance;

  final TRes Function(Fragment$MediaFragment$$Video) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? alt = _undefined,
    Object? mediaContentType = _undefined,
    Object? sources = _undefined,
    Object? previewImage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MediaFragment$$Video(
      alt: alt == _undefined ? _instance.alt : (alt as String?),
      mediaContentType:
          mediaContentType == _undefined || mediaContentType == null
          ? _instance.mediaContentType
          : (mediaContentType as Enum$MediaContentType),
      sources: sources == _undefined || sources == null
          ? _instance.sources
          : (sources as List<Fragment$MediaFragment$$Video$sources>),
      previewImage: previewImage == _undefined
          ? _instance.previewImage
          : (previewImage as Fragment$ImageFragment?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes sources(
    Iterable<Fragment$MediaFragment$$Video$sources> Function(
      Iterable<
        CopyWith$Fragment$MediaFragment$$Video$sources<
          Fragment$MediaFragment$$Video$sources
        >
      >,
    )
    _fn,
  ) => call(
    sources: _fn(
      _instance.sources.map(
        (e) => CopyWith$Fragment$MediaFragment$$Video$sources(e, (i) => i),
      ),
    ).toList(),
  );

  CopyWith$Fragment$ImageFragment<TRes> get previewImage {
    final local$previewImage = _instance.previewImage;
    return local$previewImage == null
        ? CopyWith$Fragment$ImageFragment.stub(_then(_instance))
        : CopyWith$Fragment$ImageFragment(
            local$previewImage,
            (e) => call(previewImage: e),
          );
  }
}

class _CopyWithStubImpl$Fragment$MediaFragment$$Video<TRes>
    implements CopyWith$Fragment$MediaFragment$$Video<TRes> {
  _CopyWithStubImpl$Fragment$MediaFragment$$Video(this._res);

  TRes _res;

  call({
    String? alt,
    Enum$MediaContentType? mediaContentType,
    List<Fragment$MediaFragment$$Video$sources>? sources,
    Fragment$ImageFragment? previewImage,
    String? $__typename,
  }) => _res;

  sources(_fn) => _res;

  CopyWith$Fragment$ImageFragment<TRes> get previewImage =>
      CopyWith$Fragment$ImageFragment.stub(_res);
}

class Fragment$MediaFragment$$Video$sources {
  Fragment$MediaFragment$$Video$sources({
    required this.format,
    required this.mimeType,
    required this.url,
    this.$__typename = 'VideoSource',
  });

  factory Fragment$MediaFragment$$Video$sources.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$format = json['format'];
    final l$mimeType = json['mimeType'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Fragment$MediaFragment$$Video$sources(
      format: fromJson$Enum$VideoFormat((l$format as String)),
      mimeType: (l$mimeType as String),
      url: (l$url as String),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$VideoFormat format;

  final String mimeType;

  final String url;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$format = format;
    _resultData['format'] = toJson$Enum$VideoFormat(l$format);
    final l$mimeType = mimeType;
    _resultData['mimeType'] = l$mimeType;
    final l$url = url;
    _resultData['url'] = l$url;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$format = format;
    final l$mimeType = mimeType;
    final l$url = url;
    final l$$__typename = $__typename;
    return Object.hashAll([l$format, l$mimeType, l$url, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MediaFragment$$Video$sources ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$format = format;
    final lOther$format = other.format;
    if (l$format != lOther$format) {
      return false;
    }
    final l$mimeType = mimeType;
    final lOther$mimeType = other.mimeType;
    if (l$mimeType != lOther$mimeType) {
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

extension UtilityExtension$Fragment$MediaFragment$$Video$sources
    on Fragment$MediaFragment$$Video$sources {
  CopyWith$Fragment$MediaFragment$$Video$sources<
    Fragment$MediaFragment$$Video$sources
  >
  get copyWith =>
      CopyWith$Fragment$MediaFragment$$Video$sources(this, (i) => i);
}

abstract class CopyWith$Fragment$MediaFragment$$Video$sources<TRes> {
  factory CopyWith$Fragment$MediaFragment$$Video$sources(
    Fragment$MediaFragment$$Video$sources instance,
    TRes Function(Fragment$MediaFragment$$Video$sources) then,
  ) = _CopyWithImpl$Fragment$MediaFragment$$Video$sources;

  factory CopyWith$Fragment$MediaFragment$$Video$sources.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MediaFragment$$Video$sources;

  TRes call({
    Enum$VideoFormat? format,
    String? mimeType,
    String? url,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$MediaFragment$$Video$sources<TRes>
    implements CopyWith$Fragment$MediaFragment$$Video$sources<TRes> {
  _CopyWithImpl$Fragment$MediaFragment$$Video$sources(
    this._instance,
    this._then,
  );

  final Fragment$MediaFragment$$Video$sources _instance;

  final TRes Function(Fragment$MediaFragment$$Video$sources) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? format = _undefined,
    Object? mimeType = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MediaFragment$$Video$sources(
      format: format == _undefined || format == null
          ? _instance.format
          : (format as Enum$VideoFormat),
      mimeType: mimeType == _undefined || mimeType == null
          ? _instance.mimeType
          : (mimeType as String),
      url: url == _undefined || url == null ? _instance.url : (url as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MediaFragment$$Video$sources<TRes>
    implements CopyWith$Fragment$MediaFragment$$Video$sources<TRes> {
  _CopyWithStubImpl$Fragment$MediaFragment$$Video$sources(this._res);

  TRes _res;

  call({
    Enum$VideoFormat? format,
    String? mimeType,
    String? url,
    String? $__typename,
  }) => _res;
}
