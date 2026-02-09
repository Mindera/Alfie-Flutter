class Input$ImageTransformInput {
  factory Input$ImageTransformInput({
    int? width,
    int? height,
    Enum$ImageFit? fit,
    int? scale,
    Enum$ImageFormat? format,
    int? quality,
  }) => Input$ImageTransformInput._({
    if (width != null) r'width': width,
    if (height != null) r'height': height,
    if (fit != null) r'fit': fit,
    if (scale != null) r'scale': scale,
    if (format != null) r'format': format,
    if (quality != null) r'quality': quality,
  });

  Input$ImageTransformInput._(this._$data);

  factory Input$ImageTransformInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('width')) {
      final l$width = data['width'];
      result$data['width'] = (l$width as int?);
    }
    if (data.containsKey('height')) {
      final l$height = data['height'];
      result$data['height'] = (l$height as int?);
    }
    if (data.containsKey('fit')) {
      final l$fit = data['fit'];
      result$data['fit'] = l$fit == null
          ? null
          : fromJson$Enum$ImageFit((l$fit as String));
    }
    if (data.containsKey('scale')) {
      final l$scale = data['scale'];
      result$data['scale'] = (l$scale as int?);
    }
    if (data.containsKey('format')) {
      final l$format = data['format'];
      result$data['format'] = l$format == null
          ? null
          : fromJson$Enum$ImageFormat((l$format as String));
    }
    if (data.containsKey('quality')) {
      final l$quality = data['quality'];
      result$data['quality'] = (l$quality as int?);
    }
    return Input$ImageTransformInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get width => (_$data['width'] as int?);

  int? get height => (_$data['height'] as int?);

  Enum$ImageFit? get fit => (_$data['fit'] as Enum$ImageFit?);

  int? get scale => (_$data['scale'] as int?);

  Enum$ImageFormat? get format => (_$data['format'] as Enum$ImageFormat?);

  int? get quality => (_$data['quality'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('width')) {
      final l$width = width;
      result$data['width'] = l$width;
    }
    if (_$data.containsKey('height')) {
      final l$height = height;
      result$data['height'] = l$height;
    }
    if (_$data.containsKey('fit')) {
      final l$fit = fit;
      result$data['fit'] = l$fit == null ? null : toJson$Enum$ImageFit(l$fit);
    }
    if (_$data.containsKey('scale')) {
      final l$scale = scale;
      result$data['scale'] = l$scale;
    }
    if (_$data.containsKey('format')) {
      final l$format = format;
      result$data['format'] = l$format == null
          ? null
          : toJson$Enum$ImageFormat(l$format);
    }
    if (_$data.containsKey('quality')) {
      final l$quality = quality;
      result$data['quality'] = l$quality;
    }
    return result$data;
  }

  CopyWith$Input$ImageTransformInput<Input$ImageTransformInput> get copyWith =>
      CopyWith$Input$ImageTransformInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ImageTransformInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$width = width;
    final lOther$width = other.width;
    if (_$data.containsKey('width') != other._$data.containsKey('width')) {
      return false;
    }
    if (l$width != lOther$width) {
      return false;
    }
    final l$height = height;
    final lOther$height = other.height;
    if (_$data.containsKey('height') != other._$data.containsKey('height')) {
      return false;
    }
    if (l$height != lOther$height) {
      return false;
    }
    final l$fit = fit;
    final lOther$fit = other.fit;
    if (_$data.containsKey('fit') != other._$data.containsKey('fit')) {
      return false;
    }
    if (l$fit != lOther$fit) {
      return false;
    }
    final l$scale = scale;
    final lOther$scale = other.scale;
    if (_$data.containsKey('scale') != other._$data.containsKey('scale')) {
      return false;
    }
    if (l$scale != lOther$scale) {
      return false;
    }
    final l$format = format;
    final lOther$format = other.format;
    if (_$data.containsKey('format') != other._$data.containsKey('format')) {
      return false;
    }
    if (l$format != lOther$format) {
      return false;
    }
    final l$quality = quality;
    final lOther$quality = other.quality;
    if (_$data.containsKey('quality') != other._$data.containsKey('quality')) {
      return false;
    }
    if (l$quality != lOther$quality) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$width = width;
    final l$height = height;
    final l$fit = fit;
    final l$scale = scale;
    final l$format = format;
    final l$quality = quality;
    return Object.hashAll([
      _$data.containsKey('width') ? l$width : const {},
      _$data.containsKey('height') ? l$height : const {},
      _$data.containsKey('fit') ? l$fit : const {},
      _$data.containsKey('scale') ? l$scale : const {},
      _$data.containsKey('format') ? l$format : const {},
      _$data.containsKey('quality') ? l$quality : const {},
    ]);
  }
}

abstract class CopyWith$Input$ImageTransformInput<TRes> {
  factory CopyWith$Input$ImageTransformInput(
    Input$ImageTransformInput instance,
    TRes Function(Input$ImageTransformInput) then,
  ) = _CopyWithImpl$Input$ImageTransformInput;

  factory CopyWith$Input$ImageTransformInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ImageTransformInput;

  TRes call({
    int? width,
    int? height,
    Enum$ImageFit? fit,
    int? scale,
    Enum$ImageFormat? format,
    int? quality,
  });
}

class _CopyWithImpl$Input$ImageTransformInput<TRes>
    implements CopyWith$Input$ImageTransformInput<TRes> {
  _CopyWithImpl$Input$ImageTransformInput(this._instance, this._then);

  final Input$ImageTransformInput _instance;

  final TRes Function(Input$ImageTransformInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? width = _undefined,
    Object? height = _undefined,
    Object? fit = _undefined,
    Object? scale = _undefined,
    Object? format = _undefined,
    Object? quality = _undefined,
  }) => _then(
    Input$ImageTransformInput._({
      ..._instance._$data,
      if (width != _undefined) 'width': (width as int?),
      if (height != _undefined) 'height': (height as int?),
      if (fit != _undefined) 'fit': (fit as Enum$ImageFit?),
      if (scale != _undefined) 'scale': (scale as int?),
      if (format != _undefined) 'format': (format as Enum$ImageFormat?),
      if (quality != _undefined) 'quality': (quality as int?),
    }),
  );
}

class _CopyWithStubImpl$Input$ImageTransformInput<TRes>
    implements CopyWith$Input$ImageTransformInput<TRes> {
  _CopyWithStubImpl$Input$ImageTransformInput(this._res);

  TRes _res;

  call({
    int? width,
    int? height,
    Enum$ImageFit? fit,
    int? scale,
    Enum$ImageFormat? format,
    int? quality,
  }) => _res;
}

class Input$ProductListingRefineQuery {
  factory Input$ProductListingRefineQuery({
    required Enum$ProductFilterType name,
    required List<String> values,
  }) => Input$ProductListingRefineQuery._({r'name': name, r'values': values});

  Input$ProductListingRefineQuery._(this._$data);

  factory Input$ProductListingRefineQuery.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = fromJson$Enum$ProductFilterType((l$name as String));
    final l$values = data['values'];
    result$data['values'] = (l$values as List<dynamic>)
        .map((e) => (e as String))
        .toList();
    return Input$ProductListingRefineQuery._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$ProductFilterType get name => (_$data['name'] as Enum$ProductFilterType);

  List<String> get values => (_$data['values'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = toJson$Enum$ProductFilterType(l$name);
    final l$values = values;
    result$data['values'] = l$values.map((e) => e).toList();
    return result$data;
  }

  CopyWith$Input$ProductListingRefineQuery<Input$ProductListingRefineQuery>
  get copyWith => CopyWith$Input$ProductListingRefineQuery(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ProductListingRefineQuery ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$values = values;
    return Object.hashAll([l$name, Object.hashAll(l$values.map((v) => v))]);
  }
}

abstract class CopyWith$Input$ProductListingRefineQuery<TRes> {
  factory CopyWith$Input$ProductListingRefineQuery(
    Input$ProductListingRefineQuery instance,
    TRes Function(Input$ProductListingRefineQuery) then,
  ) = _CopyWithImpl$Input$ProductListingRefineQuery;

  factory CopyWith$Input$ProductListingRefineQuery.stub(TRes res) =
      _CopyWithStubImpl$Input$ProductListingRefineQuery;

  TRes call({Enum$ProductFilterType? name, List<String>? values});
}

class _CopyWithImpl$Input$ProductListingRefineQuery<TRes>
    implements CopyWith$Input$ProductListingRefineQuery<TRes> {
  _CopyWithImpl$Input$ProductListingRefineQuery(this._instance, this._then);

  final Input$ProductListingRefineQuery _instance;

  final TRes Function(Input$ProductListingRefineQuery) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined, Object? values = _undefined}) => _then(
    Input$ProductListingRefineQuery._({
      ..._instance._$data,
      if (name != _undefined && name != null)
        'name': (name as Enum$ProductFilterType),
      if (values != _undefined && values != null)
        'values': (values as List<String>),
    }),
  );
}

class _CopyWithStubImpl$Input$ProductListingRefineQuery<TRes>
    implements CopyWith$Input$ProductListingRefineQuery<TRes> {
  _CopyWithStubImpl$Input$ProductListingRefineQuery(this._res);

  TRes _res;

  call({Enum$ProductFilterType? name, List<String>? values}) => _res;
}

enum Enum$ImageFit {
  CONTAIN,
  COVER,
  FILL,
  $unknown;

  factory Enum$ImageFit.fromJson(String value) => fromJson$Enum$ImageFit(value);

  String toJson() => toJson$Enum$ImageFit(this);
}

String toJson$Enum$ImageFit(Enum$ImageFit e) {
  switch (e) {
    case Enum$ImageFit.CONTAIN:
      return r'CONTAIN';
    case Enum$ImageFit.COVER:
      return r'COVER';
    case Enum$ImageFit.FILL:
      return r'FILL';
    case Enum$ImageFit.$unknown:
      return r'$unknown';
  }
}

Enum$ImageFit fromJson$Enum$ImageFit(String value) {
  switch (value) {
    case r'CONTAIN':
      return Enum$ImageFit.CONTAIN;
    case r'COVER':
      return Enum$ImageFit.COVER;
    case r'FILL':
      return Enum$ImageFit.FILL;
    default:
      return Enum$ImageFit.$unknown;
  }
}

enum Enum$ImageFormat {
  AVIF,
  JPG,
  PNG,
  WEBP,
  GIF,
  $unknown;

  factory Enum$ImageFormat.fromJson(String value) =>
      fromJson$Enum$ImageFormat(value);

  String toJson() => toJson$Enum$ImageFormat(this);
}

String toJson$Enum$ImageFormat(Enum$ImageFormat e) {
  switch (e) {
    case Enum$ImageFormat.AVIF:
      return r'AVIF';
    case Enum$ImageFormat.JPG:
      return r'JPG';
    case Enum$ImageFormat.PNG:
      return r'PNG';
    case Enum$ImageFormat.WEBP:
      return r'WEBP';
    case Enum$ImageFormat.GIF:
      return r'GIF';
    case Enum$ImageFormat.$unknown:
      return r'$unknown';
  }
}

Enum$ImageFormat fromJson$Enum$ImageFormat(String value) {
  switch (value) {
    case r'AVIF':
      return Enum$ImageFormat.AVIF;
    case r'JPG':
      return Enum$ImageFormat.JPG;
    case r'PNG':
      return Enum$ImageFormat.PNG;
    case r'WEBP':
      return Enum$ImageFormat.WEBP;
    case r'GIF':
      return Enum$ImageFormat.GIF;
    default:
      return Enum$ImageFormat.$unknown;
  }
}

enum Enum$MediaContentType {
  IMAGE,
  VIDEO,
  $unknown;

  factory Enum$MediaContentType.fromJson(String value) =>
      fromJson$Enum$MediaContentType(value);

  String toJson() => toJson$Enum$MediaContentType(this);
}

String toJson$Enum$MediaContentType(Enum$MediaContentType e) {
  switch (e) {
    case Enum$MediaContentType.IMAGE:
      return r'IMAGE';
    case Enum$MediaContentType.VIDEO:
      return r'VIDEO';
    case Enum$MediaContentType.$unknown:
      return r'$unknown';
  }
}

Enum$MediaContentType fromJson$Enum$MediaContentType(String value) {
  switch (value) {
    case r'IMAGE':
      return Enum$MediaContentType.IMAGE;
    case r'VIDEO':
      return Enum$MediaContentType.VIDEO;
    default:
      return Enum$MediaContentType.$unknown;
  }
}

enum Enum$NavMenuItemType {
  ACCOUNT,
  HOME,
  LISTING,
  PRODUCT,
  SEARCH,
  PAGE,
  EXTERNAL_HTTP,
  WISHLIST,
  $unknown;

  factory Enum$NavMenuItemType.fromJson(String value) =>
      fromJson$Enum$NavMenuItemType(value);

  String toJson() => toJson$Enum$NavMenuItemType(this);
}

String toJson$Enum$NavMenuItemType(Enum$NavMenuItemType e) {
  switch (e) {
    case Enum$NavMenuItemType.ACCOUNT:
      return r'ACCOUNT';
    case Enum$NavMenuItemType.HOME:
      return r'HOME';
    case Enum$NavMenuItemType.LISTING:
      return r'LISTING';
    case Enum$NavMenuItemType.PRODUCT:
      return r'PRODUCT';
    case Enum$NavMenuItemType.SEARCH:
      return r'SEARCH';
    case Enum$NavMenuItemType.PAGE:
      return r'PAGE';
    case Enum$NavMenuItemType.EXTERNAL_HTTP:
      return r'EXTERNAL_HTTP';
    case Enum$NavMenuItemType.WISHLIST:
      return r'WISHLIST';
    case Enum$NavMenuItemType.$unknown:
      return r'$unknown';
  }
}

Enum$NavMenuItemType fromJson$Enum$NavMenuItemType(String value) {
  switch (value) {
    case r'ACCOUNT':
      return Enum$NavMenuItemType.ACCOUNT;
    case r'HOME':
      return Enum$NavMenuItemType.HOME;
    case r'LISTING':
      return Enum$NavMenuItemType.LISTING;
    case r'PRODUCT':
      return Enum$NavMenuItemType.PRODUCT;
    case r'SEARCH':
      return Enum$NavMenuItemType.SEARCH;
    case r'PAGE':
      return Enum$NavMenuItemType.PAGE;
    case r'EXTERNAL_HTTP':
      return Enum$NavMenuItemType.EXTERNAL_HTTP;
    case r'WISHLIST':
      return Enum$NavMenuItemType.WISHLIST;
    default:
      return Enum$NavMenuItemType.$unknown;
  }
}

enum Enum$ProductFilterType {
  BRAND,
  COLOUR,
  PRICE,
  SIZE,
  $unknown;

  factory Enum$ProductFilterType.fromJson(String value) =>
      fromJson$Enum$ProductFilterType(value);

  String toJson() => toJson$Enum$ProductFilterType(this);
}

String toJson$Enum$ProductFilterType(Enum$ProductFilterType e) {
  switch (e) {
    case Enum$ProductFilterType.BRAND:
      return r'BRAND';
    case Enum$ProductFilterType.COLOUR:
      return r'COLOUR';
    case Enum$ProductFilterType.PRICE:
      return r'PRICE';
    case Enum$ProductFilterType.SIZE:
      return r'SIZE';
    case Enum$ProductFilterType.$unknown:
      return r'$unknown';
  }
}

Enum$ProductFilterType fromJson$Enum$ProductFilterType(String value) {
  switch (value) {
    case r'BRAND':
      return Enum$ProductFilterType.BRAND;
    case r'COLOUR':
      return Enum$ProductFilterType.COLOUR;
    case r'PRICE':
      return Enum$ProductFilterType.PRICE;
    case r'SIZE':
      return Enum$ProductFilterType.SIZE;
    default:
      return Enum$ProductFilterType.$unknown;
  }
}

enum Enum$ProductListingSort {
  LOW_TO_HIGH,
  HIGH_TO_LOW,
  A_Z,
  Z_A,
  $unknown;

  factory Enum$ProductListingSort.fromJson(String value) =>
      fromJson$Enum$ProductListingSort(value);

  String toJson() => toJson$Enum$ProductListingSort(this);
}

String toJson$Enum$ProductListingSort(Enum$ProductListingSort e) {
  switch (e) {
    case Enum$ProductListingSort.LOW_TO_HIGH:
      return r'LOW_TO_HIGH';
    case Enum$ProductListingSort.HIGH_TO_LOW:
      return r'HIGH_TO_LOW';
    case Enum$ProductListingSort.A_Z:
      return r'A_Z';
    case Enum$ProductListingSort.Z_A:
      return r'Z_A';
    case Enum$ProductListingSort.$unknown:
      return r'$unknown';
  }
}

Enum$ProductListingSort fromJson$Enum$ProductListingSort(String value) {
  switch (value) {
    case r'LOW_TO_HIGH':
      return Enum$ProductListingSort.LOW_TO_HIGH;
    case r'HIGH_TO_LOW':
      return Enum$ProductListingSort.HIGH_TO_LOW;
    case r'A_Z':
      return Enum$ProductListingSort.A_Z;
    case r'Z_A':
      return Enum$ProductListingSort.Z_A;
    default:
      return Enum$ProductListingSort.$unknown;
  }
}

enum Enum$VideoFormat {
  MP4,
  WEBM,
  $unknown;

  factory Enum$VideoFormat.fromJson(String value) =>
      fromJson$Enum$VideoFormat(value);

  String toJson() => toJson$Enum$VideoFormat(this);
}

String toJson$Enum$VideoFormat(Enum$VideoFormat e) {
  switch (e) {
    case Enum$VideoFormat.MP4:
      return r'MP4';
    case Enum$VideoFormat.WEBM:
      return r'WEBM';
    case Enum$VideoFormat.$unknown:
      return r'$unknown';
  }
}

Enum$VideoFormat fromJson$Enum$VideoFormat(String value) {
  switch (value) {
    case r'MP4':
      return Enum$VideoFormat.MP4;
    case r'WEBM':
      return Enum$VideoFormat.WEBM;
    default:
      return Enum$VideoFormat.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{
  'Media': {'Image', 'Video'},
};
