import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$SizeTreeFragment implements Fragment$SizeFragment {
  Fragment$SizeTreeFragment({
    required this.id,
    required this.value,
    this.scale,
    this.description,
    this.$__typename = 'Size',
    this.sizeGuide,
  });

  factory Fragment$SizeTreeFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$value = json['value'];
    final l$scale = json['scale'];
    final l$description = json['description'];
    final l$$__typename = json['__typename'];
    final l$sizeGuide = json['sizeGuide'];
    return Fragment$SizeTreeFragment(
      id: (l$id as String),
      value: (l$value as String),
      scale: (l$scale as String?),
      description: (l$description as String?),
      $__typename: (l$$__typename as String),
      sizeGuide: l$sizeGuide == null
          ? null
          : Fragment$SizeGuideTreeFragment.fromJson(
              (l$sizeGuide as Map<String, dynamic>),
            ),
    );
  }

  final String id;

  final String value;

  final String? scale;

  final String? description;

  final String $__typename;

  final Fragment$SizeGuideTreeFragment? sizeGuide;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$scale = scale;
    _resultData['scale'] = l$scale;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$sizeGuide = sizeGuide;
    _resultData['sizeGuide'] = l$sizeGuide?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$value = value;
    final l$scale = scale;
    final l$description = description;
    final l$$__typename = $__typename;
    final l$sizeGuide = sizeGuide;
    return Object.hashAll([
      l$id,
      l$value,
      l$scale,
      l$description,
      l$$__typename,
      l$sizeGuide,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SizeTreeFragment ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$scale = scale;
    final lOther$scale = other.scale;
    if (l$scale != lOther$scale) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$sizeGuide = sizeGuide;
    final lOther$sizeGuide = other.sizeGuide;
    if (l$sizeGuide != lOther$sizeGuide) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$SizeTreeFragment
    on Fragment$SizeTreeFragment {
  CopyWith$Fragment$SizeTreeFragment<Fragment$SizeTreeFragment> get copyWith =>
      CopyWith$Fragment$SizeTreeFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SizeTreeFragment<TRes> {
  factory CopyWith$Fragment$SizeTreeFragment(
    Fragment$SizeTreeFragment instance,
    TRes Function(Fragment$SizeTreeFragment) then,
  ) = _CopyWithImpl$Fragment$SizeTreeFragment;

  factory CopyWith$Fragment$SizeTreeFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SizeTreeFragment;

  TRes call({
    String? id,
    String? value,
    String? scale,
    String? description,
    String? $__typename,
    Fragment$SizeGuideTreeFragment? sizeGuide,
  });
  CopyWith$Fragment$SizeGuideTreeFragment<TRes> get sizeGuide;
}

class _CopyWithImpl$Fragment$SizeTreeFragment<TRes>
    implements CopyWith$Fragment$SizeTreeFragment<TRes> {
  _CopyWithImpl$Fragment$SizeTreeFragment(this._instance, this._then);

  final Fragment$SizeTreeFragment _instance;

  final TRes Function(Fragment$SizeTreeFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? value = _undefined,
    Object? scale = _undefined,
    Object? description = _undefined,
    Object? $__typename = _undefined,
    Object? sizeGuide = _undefined,
  }) => _then(
    Fragment$SizeTreeFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      value: value == _undefined || value == null
          ? _instance.value
          : (value as String),
      scale: scale == _undefined ? _instance.scale : (scale as String?),
      description: description == _undefined
          ? _instance.description
          : (description as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
      sizeGuide: sizeGuide == _undefined
          ? _instance.sizeGuide
          : (sizeGuide as Fragment$SizeGuideTreeFragment?),
    ),
  );

  CopyWith$Fragment$SizeGuideTreeFragment<TRes> get sizeGuide {
    final local$sizeGuide = _instance.sizeGuide;
    return local$sizeGuide == null
        ? CopyWith$Fragment$SizeGuideTreeFragment.stub(_then(_instance))
        : CopyWith$Fragment$SizeGuideTreeFragment(
            local$sizeGuide,
            (e) => call(sizeGuide: e),
          );
  }
}

class _CopyWithStubImpl$Fragment$SizeTreeFragment<TRes>
    implements CopyWith$Fragment$SizeTreeFragment<TRes> {
  _CopyWithStubImpl$Fragment$SizeTreeFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? value,
    String? scale,
    String? description,
    String? $__typename,
    Fragment$SizeGuideTreeFragment? sizeGuide,
  }) => _res;

  CopyWith$Fragment$SizeGuideTreeFragment<TRes> get sizeGuide =>
      CopyWith$Fragment$SizeGuideTreeFragment.stub(_res);
}

const fragmentDefinitionSizeTreeFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SizeTreeFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Size'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FragmentSpreadNode(
        name: NameNode(value: 'SizeFragment'),
        directives: [],
      ),
      FieldNode(
        name: NameNode(value: 'sizeGuide'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'SizeGuideTreeFragment'),
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
const documentNodeFragmentSizeTreeFragment = DocumentNode(
  definitions: [
    fragmentDefinitionSizeTreeFragment,
    fragmentDefinitionSizeFragment,
    fragmentDefinitionSizeGuideTreeFragment,
    fragmentDefinitionSizeGuideFragment,
  ],
);

extension ClientExtension$Fragment$SizeTreeFragment on graphql.GraphQLClient {
  void writeFragment$SizeTreeFragment({
    required Fragment$SizeTreeFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SizeTreeFragment',
        document: documentNodeFragmentSizeTreeFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SizeTreeFragment? readFragment$SizeTreeFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SizeTreeFragment',
          document: documentNodeFragmentSizeTreeFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$SizeTreeFragment.fromJson(result);
  }
}

class Fragment$SizeFragment {
  Fragment$SizeFragment({
    required this.id,
    required this.value,
    this.scale,
    this.description,
    this.$__typename = 'Size',
  });

  factory Fragment$SizeFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$value = json['value'];
    final l$scale = json['scale'];
    final l$description = json['description'];
    final l$$__typename = json['__typename'];
    return Fragment$SizeFragment(
      id: (l$id as String),
      value: (l$value as String),
      scale: (l$scale as String?),
      description: (l$description as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String value;

  final String? scale;

  final String? description;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$scale = scale;
    _resultData['scale'] = l$scale;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$value = value;
    final l$scale = scale;
    final l$description = description;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$value,
      l$scale,
      l$description,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SizeFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$scale = scale;
    final lOther$scale = other.scale;
    if (l$scale != lOther$scale) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
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

extension UtilityExtension$Fragment$SizeFragment on Fragment$SizeFragment {
  CopyWith$Fragment$SizeFragment<Fragment$SizeFragment> get copyWith =>
      CopyWith$Fragment$SizeFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SizeFragment<TRes> {
  factory CopyWith$Fragment$SizeFragment(
    Fragment$SizeFragment instance,
    TRes Function(Fragment$SizeFragment) then,
  ) = _CopyWithImpl$Fragment$SizeFragment;

  factory CopyWith$Fragment$SizeFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SizeFragment;

  TRes call({
    String? id,
    String? value,
    String? scale,
    String? description,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$SizeFragment<TRes>
    implements CopyWith$Fragment$SizeFragment<TRes> {
  _CopyWithImpl$Fragment$SizeFragment(this._instance, this._then);

  final Fragment$SizeFragment _instance;

  final TRes Function(Fragment$SizeFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? value = _undefined,
    Object? scale = _undefined,
    Object? description = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$SizeFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      value: value == _undefined || value == null
          ? _instance.value
          : (value as String),
      scale: scale == _undefined ? _instance.scale : (scale as String?),
      description: description == _undefined
          ? _instance.description
          : (description as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$SizeFragment<TRes>
    implements CopyWith$Fragment$SizeFragment<TRes> {
  _CopyWithStubImpl$Fragment$SizeFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? value,
    String? scale,
    String? description,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionSizeFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SizeFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Size'), isNonNull: false),
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
        name: NameNode(value: 'value'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'scale'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
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
const documentNodeFragmentSizeFragment = DocumentNode(
  definitions: [fragmentDefinitionSizeFragment],
);

extension ClientExtension$Fragment$SizeFragment on graphql.GraphQLClient {
  void writeFragment$SizeFragment({
    required Fragment$SizeFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SizeFragment',
        document: documentNodeFragmentSizeFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SizeFragment? readFragment$SizeFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SizeFragment',
          document: documentNodeFragmentSizeFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$SizeFragment.fromJson(result);
  }
}

class Fragment$SizeGuideTreeFragment implements Fragment$SizeGuideFragment {
  Fragment$SizeGuideTreeFragment({
    required this.id,
    required this.name,
    this.description,
    this.$__typename = 'SizeGuide',
    required this.sizes,
  });

  factory Fragment$SizeGuideTreeFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$description = json['description'];
    final l$$__typename = json['__typename'];
    final l$sizes = json['sizes'];
    return Fragment$SizeGuideTreeFragment(
      id: (l$id as String),
      name: (l$name as String),
      description: (l$description as String?),
      $__typename: (l$$__typename as String),
      sizes: (l$sizes as List<dynamic>)
          .map(
            (e) => Fragment$SizeGuideTreeFragment$sizes.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
    );
  }

  final String id;

  final String name;

  final String? description;

  final String $__typename;

  final List<Fragment$SizeGuideTreeFragment$sizes> sizes;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$sizes = sizes;
    _resultData['sizes'] = l$sizes.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$description = description;
    final l$$__typename = $__typename;
    final l$sizes = sizes;
    return Object.hashAll([
      l$id,
      l$name,
      l$description,
      l$$__typename,
      Object.hashAll(l$sizes.map((v) => v)),
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SizeGuideTreeFragment ||
        runtimeType != other.runtimeType) {
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
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$sizes = sizes;
    final lOther$sizes = other.sizes;
    if (l$sizes.length != lOther$sizes.length) {
      return false;
    }
    for (int i = 0; i < l$sizes.length; i++) {
      final l$sizes$entry = l$sizes[i];
      final lOther$sizes$entry = lOther$sizes[i];
      if (l$sizes$entry != lOther$sizes$entry) {
        return false;
      }
    }
    return true;
  }
}

extension UtilityExtension$Fragment$SizeGuideTreeFragment
    on Fragment$SizeGuideTreeFragment {
  CopyWith$Fragment$SizeGuideTreeFragment<Fragment$SizeGuideTreeFragment>
  get copyWith => CopyWith$Fragment$SizeGuideTreeFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SizeGuideTreeFragment<TRes> {
  factory CopyWith$Fragment$SizeGuideTreeFragment(
    Fragment$SizeGuideTreeFragment instance,
    TRes Function(Fragment$SizeGuideTreeFragment) then,
  ) = _CopyWithImpl$Fragment$SizeGuideTreeFragment;

  factory CopyWith$Fragment$SizeGuideTreeFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SizeGuideTreeFragment;

  TRes call({
    String? id,
    String? name,
    String? description,
    String? $__typename,
    List<Fragment$SizeGuideTreeFragment$sizes>? sizes,
  });
  TRes sizes(
    Iterable<Fragment$SizeGuideTreeFragment$sizes> Function(
      Iterable<
        CopyWith$Fragment$SizeGuideTreeFragment$sizes<
          Fragment$SizeGuideTreeFragment$sizes
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$SizeGuideTreeFragment<TRes>
    implements CopyWith$Fragment$SizeGuideTreeFragment<TRes> {
  _CopyWithImpl$Fragment$SizeGuideTreeFragment(this._instance, this._then);

  final Fragment$SizeGuideTreeFragment _instance;

  final TRes Function(Fragment$SizeGuideTreeFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? description = _undefined,
    Object? $__typename = _undefined,
    Object? sizes = _undefined,
  }) => _then(
    Fragment$SizeGuideTreeFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      description: description == _undefined
          ? _instance.description
          : (description as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
      sizes: sizes == _undefined || sizes == null
          ? _instance.sizes
          : (sizes as List<Fragment$SizeGuideTreeFragment$sizes>),
    ),
  );

  TRes sizes(
    Iterable<Fragment$SizeGuideTreeFragment$sizes> Function(
      Iterable<
        CopyWith$Fragment$SizeGuideTreeFragment$sizes<
          Fragment$SizeGuideTreeFragment$sizes
        >
      >,
    )
    _fn,
  ) => call(
    sizes: _fn(
      _instance.sizes.map(
        (e) => CopyWith$Fragment$SizeGuideTreeFragment$sizes(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$SizeGuideTreeFragment<TRes>
    implements CopyWith$Fragment$SizeGuideTreeFragment<TRes> {
  _CopyWithStubImpl$Fragment$SizeGuideTreeFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? description,
    String? $__typename,
    List<Fragment$SizeGuideTreeFragment$sizes>? sizes,
  }) => _res;

  sizes(_fn) => _res;
}

const fragmentDefinitionSizeGuideTreeFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SizeGuideTreeFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'SizeGuide'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FragmentSpreadNode(
        name: NameNode(value: 'SizeGuideFragment'),
        directives: [],
      ),
      FieldNode(
        name: NameNode(value: 'sizes'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'SizeFragment'),
              directives: [],
            ),
            FieldNode(
              name: NameNode(value: 'sizeGuide'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(
                selections: [
                  FragmentSpreadNode(
                    name: NameNode(value: 'SizeGuideFragment'),
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
const documentNodeFragmentSizeGuideTreeFragment = DocumentNode(
  definitions: [
    fragmentDefinitionSizeGuideTreeFragment,
    fragmentDefinitionSizeGuideFragment,
    fragmentDefinitionSizeFragment,
  ],
);

extension ClientExtension$Fragment$SizeGuideTreeFragment
    on graphql.GraphQLClient {
  void writeFragment$SizeGuideTreeFragment({
    required Fragment$SizeGuideTreeFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SizeGuideTreeFragment',
        document: documentNodeFragmentSizeGuideTreeFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SizeGuideTreeFragment? readFragment$SizeGuideTreeFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SizeGuideTreeFragment',
          document: documentNodeFragmentSizeGuideTreeFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$SizeGuideTreeFragment.fromJson(result);
  }
}

class Fragment$SizeGuideTreeFragment$sizes implements Fragment$SizeFragment {
  Fragment$SizeGuideTreeFragment$sizes({
    required this.id,
    required this.value,
    this.scale,
    this.description,
    this.$__typename = 'Size',
    this.sizeGuide,
  });

  factory Fragment$SizeGuideTreeFragment$sizes.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$value = json['value'];
    final l$scale = json['scale'];
    final l$description = json['description'];
    final l$$__typename = json['__typename'];
    final l$sizeGuide = json['sizeGuide'];
    return Fragment$SizeGuideTreeFragment$sizes(
      id: (l$id as String),
      value: (l$value as String),
      scale: (l$scale as String?),
      description: (l$description as String?),
      $__typename: (l$$__typename as String),
      sizeGuide: l$sizeGuide == null
          ? null
          : Fragment$SizeGuideFragment.fromJson(
              (l$sizeGuide as Map<String, dynamic>),
            ),
    );
  }

  final String id;

  final String value;

  final String? scale;

  final String? description;

  final String $__typename;

  final Fragment$SizeGuideFragment? sizeGuide;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$scale = scale;
    _resultData['scale'] = l$scale;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$sizeGuide = sizeGuide;
    _resultData['sizeGuide'] = l$sizeGuide?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$value = value;
    final l$scale = scale;
    final l$description = description;
    final l$$__typename = $__typename;
    final l$sizeGuide = sizeGuide;
    return Object.hashAll([
      l$id,
      l$value,
      l$scale,
      l$description,
      l$$__typename,
      l$sizeGuide,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SizeGuideTreeFragment$sizes ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$scale = scale;
    final lOther$scale = other.scale;
    if (l$scale != lOther$scale) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$sizeGuide = sizeGuide;
    final lOther$sizeGuide = other.sizeGuide;
    if (l$sizeGuide != lOther$sizeGuide) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$SizeGuideTreeFragment$sizes
    on Fragment$SizeGuideTreeFragment$sizes {
  CopyWith$Fragment$SizeGuideTreeFragment$sizes<
    Fragment$SizeGuideTreeFragment$sizes
  >
  get copyWith => CopyWith$Fragment$SizeGuideTreeFragment$sizes(this, (i) => i);
}

abstract class CopyWith$Fragment$SizeGuideTreeFragment$sizes<TRes> {
  factory CopyWith$Fragment$SizeGuideTreeFragment$sizes(
    Fragment$SizeGuideTreeFragment$sizes instance,
    TRes Function(Fragment$SizeGuideTreeFragment$sizes) then,
  ) = _CopyWithImpl$Fragment$SizeGuideTreeFragment$sizes;

  factory CopyWith$Fragment$SizeGuideTreeFragment$sizes.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SizeGuideTreeFragment$sizes;

  TRes call({
    String? id,
    String? value,
    String? scale,
    String? description,
    String? $__typename,
    Fragment$SizeGuideFragment? sizeGuide,
  });
  CopyWith$Fragment$SizeGuideFragment<TRes> get sizeGuide;
}

class _CopyWithImpl$Fragment$SizeGuideTreeFragment$sizes<TRes>
    implements CopyWith$Fragment$SizeGuideTreeFragment$sizes<TRes> {
  _CopyWithImpl$Fragment$SizeGuideTreeFragment$sizes(
    this._instance,
    this._then,
  );

  final Fragment$SizeGuideTreeFragment$sizes _instance;

  final TRes Function(Fragment$SizeGuideTreeFragment$sizes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? value = _undefined,
    Object? scale = _undefined,
    Object? description = _undefined,
    Object? $__typename = _undefined,
    Object? sizeGuide = _undefined,
  }) => _then(
    Fragment$SizeGuideTreeFragment$sizes(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      value: value == _undefined || value == null
          ? _instance.value
          : (value as String),
      scale: scale == _undefined ? _instance.scale : (scale as String?),
      description: description == _undefined
          ? _instance.description
          : (description as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
      sizeGuide: sizeGuide == _undefined
          ? _instance.sizeGuide
          : (sizeGuide as Fragment$SizeGuideFragment?),
    ),
  );

  CopyWith$Fragment$SizeGuideFragment<TRes> get sizeGuide {
    final local$sizeGuide = _instance.sizeGuide;
    return local$sizeGuide == null
        ? CopyWith$Fragment$SizeGuideFragment.stub(_then(_instance))
        : CopyWith$Fragment$SizeGuideFragment(
            local$sizeGuide,
            (e) => call(sizeGuide: e),
          );
  }
}

class _CopyWithStubImpl$Fragment$SizeGuideTreeFragment$sizes<TRes>
    implements CopyWith$Fragment$SizeGuideTreeFragment$sizes<TRes> {
  _CopyWithStubImpl$Fragment$SizeGuideTreeFragment$sizes(this._res);

  TRes _res;

  call({
    String? id,
    String? value,
    String? scale,
    String? description,
    String? $__typename,
    Fragment$SizeGuideFragment? sizeGuide,
  }) => _res;

  CopyWith$Fragment$SizeGuideFragment<TRes> get sizeGuide =>
      CopyWith$Fragment$SizeGuideFragment.stub(_res);
}

class Fragment$SizeGuideFragment {
  Fragment$SizeGuideFragment({
    required this.id,
    required this.name,
    this.description,
    this.$__typename = 'SizeGuide',
  });

  factory Fragment$SizeGuideFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$description = json['description'];
    final l$$__typename = json['__typename'];
    return Fragment$SizeGuideFragment(
      id: (l$id as String),
      name: (l$name as String),
      description: (l$description as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? description;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$description = description;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$name, l$description, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SizeGuideFragment ||
        runtimeType != other.runtimeType) {
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
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
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

extension UtilityExtension$Fragment$SizeGuideFragment
    on Fragment$SizeGuideFragment {
  CopyWith$Fragment$SizeGuideFragment<Fragment$SizeGuideFragment>
  get copyWith => CopyWith$Fragment$SizeGuideFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$SizeGuideFragment<TRes> {
  factory CopyWith$Fragment$SizeGuideFragment(
    Fragment$SizeGuideFragment instance,
    TRes Function(Fragment$SizeGuideFragment) then,
  ) = _CopyWithImpl$Fragment$SizeGuideFragment;

  factory CopyWith$Fragment$SizeGuideFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$SizeGuideFragment;

  TRes call({
    String? id,
    String? name,
    String? description,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$SizeGuideFragment<TRes>
    implements CopyWith$Fragment$SizeGuideFragment<TRes> {
  _CopyWithImpl$Fragment$SizeGuideFragment(this._instance, this._then);

  final Fragment$SizeGuideFragment _instance;

  final TRes Function(Fragment$SizeGuideFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? description = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$SizeGuideFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      description: description == _undefined
          ? _instance.description
          : (description as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$SizeGuideFragment<TRes>
    implements CopyWith$Fragment$SizeGuideFragment<TRes> {
  _CopyWithStubImpl$Fragment$SizeGuideFragment(this._res);

  TRes _res;

  call({String? id, String? name, String? description, String? $__typename}) =>
      _res;
}

const fragmentDefinitionSizeGuideFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SizeGuideFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'SizeGuide'), isNonNull: false),
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
        name: NameNode(value: 'description'),
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
const documentNodeFragmentSizeGuideFragment = DocumentNode(
  definitions: [fragmentDefinitionSizeGuideFragment],
);

extension ClientExtension$Fragment$SizeGuideFragment on graphql.GraphQLClient {
  void writeFragment$SizeGuideFragment({
    required Fragment$SizeGuideFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SizeGuideFragment',
        document: documentNodeFragmentSizeGuideFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$SizeGuideFragment? readFragment$SizeGuideFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SizeGuideFragment',
          document: documentNodeFragmentSizeGuideFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$SizeGuideFragment.fromJson(result);
  }
}
