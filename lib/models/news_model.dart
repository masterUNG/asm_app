import 'dart:convert';

class NewsModel {
  String newsid;
  String topic;
  String content;
  String pic;
  NewsModel({
    required this.newsid,
    required this.topic,
    required this.content,
    required this.pic,
  });

  NewsModel copyWith({
    String? newsid,
    String? topic,
    String? content,
    String? pic,
  }) {
    return NewsModel(
      newsid: newsid ?? this.newsid,
      topic: topic ?? this.topic,
      content: content ?? this.content,
      pic: pic ?? this.pic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newsid': newsid,
      'topic': topic,
      'content': content,
      'pic': pic,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      newsid: map['newsid'],
      topic: map['topic'],
      content: map['content'],
      pic: map['pic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(newsid: $newsid, topic: $topic, content: $content, pic: $pic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.newsid == newsid &&
        other.topic == topic &&
        other.content == content &&
        other.pic == pic;
  }

  @override
  int get hashCode {
    return newsid.hashCode ^ topic.hashCode ^ content.hashCode ^ pic.hashCode;
  }
}
