class TreeCountResponse {
  final int totalCount;
  final int connectedCount;
  final List<Map<String, int>> woodCounts;

  TreeCountResponse({
    required this.totalCount,
    required this.connectedCount,
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
      woodCounts: woodCounts,
    );
  }
}
