class TreeCountResponse {
  final int totalCount;
  final int connectedCount;
  final int todayCount;
  final int myCount;
  final List<Map<String, int>> woodCounts;

  TreeCountResponse({
    required this.totalCount,
    required this.connectedCount,
    required this.todayCount,
    required this.myCount,
    required this.woodCounts,
  });

  factory TreeCountResponse.fromJson(Map<String, dynamic> json) {
    List woodCountsJson = json['wood_count'] as List;
    final woodCounts = woodCountsJson
        .map((json) =>
            <String, int>{json['wood_name']: int.parse(json['count'])})
        .toList();

    return TreeCountResponse(
      totalCount: json['count'] as int,
      connectedCount: json['match_count'] as int,
      todayCount: json['today_count'] as int,
      myCount: json['my_count'] as int,
      woodCounts: woodCounts,
    );
  }

  TreeCountResponse copyWith(
      {int? totalCount,
      int? connectedCount,
      int? todayCount,
      int? myCount,
      List<Map<String, int>>? woodCounts}) {
    return TreeCountResponse(
        totalCount: totalCount ?? this.totalCount,
        connectedCount: connectedCount ?? this.connectedCount,
        todayCount: todayCount ?? this.todayCount,
        myCount: myCount ?? this.myCount,
        woodCounts: woodCounts ?? this.woodCounts);
  }
}
