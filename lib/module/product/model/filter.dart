import 'dart:convert';

class Filter {
  Filter({
    this.categories,
    this.attributes,
  });

  final List<FilterCategory> categories;
  final List<FilterAttribute> attributes;

  Filter copyWith({
    List<FilterCategory> categories,
    List<FilterAttribute> attributes,
  }) {
    return Filter(
      categories: categories ?? this.categories,
      attributes: attributes ?? this.attributes,
    );
  }

  factory Filter.fromJson(String str) {
    return Filter.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic> json) {
    return Filter(
      categories: json["categories"] == null
          ? null
          : List<FilterCategory>.from((json["categories"] as List)
              .map((x) => FilterCategory.fromMap(x as Map<String, dynamic>))),
      attributes: json["attributes"] == null
          ? null
          : List<FilterAttribute>.from((json["attributes"] as List)
              .map((x) => FilterAttribute.fromMap(x as Map<String, dynamic>))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "categories": categories == null
          ? null
          : List<dynamic>.from(categories.map((x) => x.toMap())),
      "attributes": attributes == null
          ? null
          : List<dynamic>.from(attributes.map((x) => x.toMap())),
    };
  }
}

class FilterAttribute {
  FilterAttribute({
    this.id,
    this.name,
    this.displayType,
    this.valueIds,
  });

  final int id;
  final String name;
  final DisplayType displayType;
  final List<ValueId> valueIds;

  FilterAttribute copyWith({
    int id,
    String name,
    DisplayType displayType,
    List<ValueId> valueIds,
  }) {
    return FilterAttribute(
      id: id ?? this.id,
      name: name ?? this.name,
      displayType: displayType ?? this.displayType,
      valueIds: valueIds ?? this.valueIds,
    );
  }

  factory FilterAttribute.fromJson(String str) {
    return FilterAttribute.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory FilterAttribute.fromMap(Map<String, dynamic> json) {
    return FilterAttribute(
      id: json["id"] as int,
      name: json["name"] as String,
      displayType: json["display_type"] == null
          ? null
          : displayTypeValues.map[json["display_type"]],
      valueIds: json["value_ids"] == null
          ? null
          : List<ValueId>.from((json["value_ids"] as List).map(
              (x) => ValueId.fromMap(x as Map<String, dynamic>),
            )),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "display_type":
            displayType == null ? null : displayTypeValues.reverse[displayType],
        "value_ids": valueIds == null
            ? null
            : List<dynamic>.from(valueIds.map((x) => x.toMap())),
      };
}

enum DisplayType { RADIO, COLOR, SELECT }

final displayTypeValues = EnumValues({
  "color": DisplayType.COLOR,
  "radio": DisplayType.RADIO,
  "select": DisplayType.SELECT
});

class ValueId {
  ValueId({
    this.id,
    this.name,
    this.htmlColor,
  });

  final int id;
  final String name;
  final HtmlColor htmlColor;

  ValueId copyWith({
    int id,
    String name,
    HtmlColor htmlColor,
  }) {
    return ValueId(
      id: id ?? this.id,
      name: name ?? this.name,
      htmlColor: htmlColor ?? this.htmlColor,
    );
  }

  factory ValueId.fromJson(String str) {
    return ValueId.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory ValueId.fromMap(Map<String, dynamic> json) => ValueId(
        id: json["id"] as int,
        name: json["name"] as String,
        htmlColor: json["html_color"] == null
            ? null
            : htmlColorValues.map[json["html_color"]],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "html_color":
            htmlColor == null ? null : htmlColorValues.reverse[htmlColor],
      };
}

enum HtmlColor { EMPTY, FFFFFF, THE_000000 }

final htmlColorValues = EnumValues({
  "": HtmlColor.EMPTY,
  "#FFFFFF": HtmlColor.FFFFFF,
  "#000000": HtmlColor.THE_000000
});

class FilterCategory {
  FilterCategory({
    this.id,
    this.name,
    this.pathName,
    this.parentCategory,
    this.description,
    this.image,
    this.banner,
  });

  final int id;
  final String name;
  final String pathName;
  final ParentCategory parentCategory;
  final Description description;
  final String image;
  final List<dynamic> banner;

  FilterCategory copyWith({
    int id,
    String name,
    String pathName,
    ParentCategory parentCategory,
    Description description,
    String image,
    List<dynamic> banner,
  }) =>
      FilterCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        pathName: pathName ?? this.pathName,
        parentCategory: parentCategory ?? this.parentCategory,
        description: description ?? this.description,
        image: image ?? this.image,
        banner: banner ?? this.banner,
      );

  factory FilterCategory.fromJson(String str) {
    return FilterCategory.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory FilterCategory.fromMap(Map<String, dynamic> json) {
    return FilterCategory(
      id: json["id"] as int,
      name: json["name"] as String,
      pathName: json["path_name"] as String,
      parentCategory: json["parent_category"] == null
          ? null
          : ParentCategory.fromMap(
              json["parent_category"] as Map<String, dynamic>,
            ),
      description: json["description"] == null
          ? null
          : descriptionValues.map[json["description"]],
      image: json["image"] as String,
      banner: json["banner"] == null
          ? null
          : List<dynamic>.from((json["banner"] as List).map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "path_name": pathName,
        "parent_category": parentCategory?.toMap(),
        "description":
            description == null ? null : descriptionValues.reverse[description],
        "image": image,
        "banner":
            banner == null ? null : List<dynamic>.from(banner.map((x) => x)),
      };
}

enum Description { EMPTY, P_BR_P }

final descriptionValues =
    EnumValues({"": Description.EMPTY, "<p><br></p>": Description.P_BR_P});

class ParentCategory {
  ParentCategory({
    this.id,
    this.name,
    this.pathName,
  });

  final int id;
  final String name;
  final String pathName;

  ParentCategory copyWith({
    int id,
    String name,
    String pathName,
  }) =>
      ParentCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        pathName: pathName ?? this.pathName,
      );

  factory ParentCategory.fromJson(String str) =>
      ParentCategory.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory ParentCategory.fromMap(Map<String, dynamic> json) {
    return ParentCategory(
      id: json["id"] as int,
      name: json["name"] as String,
      pathName: json["path_name"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "path_name": pathName,
    };
  }
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
