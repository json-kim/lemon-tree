class Tree {
  final int id; // 나무 id
  final double lng; // 나무 경도 좌표
  final double lat; // 나무 위도 좌표
  final int tileX; // 나무 타일 x 좌표
  final int tileY; // 나무 타일 Y 좌표
  final String woodName; // 나무 수종 이름
  final String guName; // 나무 위치 구 이름
  final String streetName; // 나무 위치 도로명 이름
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
    required this.status,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: int.parse(json['_id']),
      lng: double.parse(json['lng']),
      lat: double.parse(json['lat']),
      tileX: int.parse(json['tile_x']),
      tileY: int.parse(json['tile_y']),
      woodName: json['wood_name'] as String,
      guName: json['gu_name'] as String,
      streetName: json['street_name'] as String,
      status: int.parse(json['status']) == 0 ? false : true,
    );
  }
}
