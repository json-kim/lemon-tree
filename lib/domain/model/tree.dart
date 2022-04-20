class Tree {
  final int id; // 나무 id
  final double lng; // 나무 경도 좌표
  final double lat; // 나무 위도 좌표
  final int tileX; // 나무 타일 x 좌표
  final int tileY; // 나무 타일 Y 좌표
  final String woodName; // 나무 수종 이름
  final String guName; // 나무 위치 구 이름
  final String streetName; // 나무 위치 도로명 이름
  final bool private; // 나무 공개 여부 (0은 공개, 1은 비공개)
  final bool status; // 나무 연결 여부 (0은 비연결, 1은 연결)

  Tree({
    required this.id,
    required this.lng,
    required this.lat,
    required this.tileX,
    required this.tileY,
    required this.woodName,
    required this.guName,
    required this.streetName,
    required this.private,
    required this.status,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['_id'] as int,
      lng: json['lng'] as double,
      lat: json['lat'] as double,
      tileX: json['tile_x'] as int,
      tileY: json['tile_y'] as int,
      woodName: json['wood_name'] as String,
      guName: json['gu_name'] as String,
      streetName: json['street_name'] as String,
      private: json['private'] == 0 ? false : true,
      status: json['status'] == 0 ? false : true,
    );
  }
}
