import 'dart:convert';

class KnowModel {
  String knowid;
  String title;
  String content;
  String pic;
  KnowModel({
    required this.knowid,
    required this.title,
    required this.content,
    required this.pic,
  });

  KnowModel copyWith({
    String? knowid,
    String? title,
    String? content,
    String? pic,
  }) {
    return KnowModel(
      knowid: knowid ?? this.knowid,
      title: title ?? this.title,
      content: content ?? this.content,
      pic: pic ?? this.pic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'knowid': knowid,
      'title': title,
      'content': content,
      'pic': pic,
    };
  }

  factory KnowModel.fromMap(Map<String, dynamic> map) {
    return KnowModel(
      knowid: map['knowid'],
      title: map['title'],
      content: map['content'],
      pic: map['pic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KnowModel.fromJson(String source) =>
      KnowModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KnowModel(knowid: $knowid, title: $title, content: $content, pic: $pic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KnowModel &&
        other.knowid == knowid &&
        other.title == title &&
        other.content == content &&
        other.pic == pic;
  }

  @override
  int get hashCode {
    return knowid.hashCode ^ title.hashCode ^ content.hashCode ^ pic.hashCode;
  }
}
