class Memory {
  final int id; // 메모리 id
  final int treeId; // 나무 id
  final int memberId; // 작성자 id
  final double lng; // 나무 경도 좌표
  final double lat; // 나무 위도 좌표
  final String woodName; // 나무 수종 이름
  final String guName; // 나무 위치 구 이름
  final String streetName; // 나무 위치 도로명 이름
  final String writerName; // 작성자 닉네임
  final String content; // 작성 내용
  final DateTime createdAt; // 작성 시간

  Memory({
    required this.id,
    required this.treeId,
    required this.memberId,
    required this.lng,
    required this.lat,
    required this.woodName,
    required this.guName,
    required this.streetName,
    required this.writerName,
    required this.content,
    required this.createdAt,
  });

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      id: int.parse(json['_id']),
      treeId: int.parse(json['tree_id']),
      memberId: int.parse(json['member_id']),
      lng: double.parse(json['lng']),
      lat: double.parse(json['lat']),
      woodName: json['wood_name'] as String,
      guName: json['gu_name'] as String,
      streetName: json['street_name'] as String,
      writerName: json['name'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
