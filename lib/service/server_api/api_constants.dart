class ApiConstants {
  static const String scheme = 'https';
  static const String base = 'tkdqjaos1.cafe24.com';
  static const String contentType = 'application/x-www-form-urlencoded';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static const String email = 'email';
  static const String pw = 'pw';
  static const String name = 'name';
  static const String content = 'content';
  static const String memberId = 'member_id';
  static const String woodName = 'wood_name';
  static const String guName = 'gu_name';
  static const String treeId = 'tree_id';
  static const String theme = 'theme';
  static const String themeId = 'theme_id';
  static const String private = 'private';
  static const String tileX = 'tile_x';
  static const String tileY = 'tile_y';
  static const String page = 'page';
  static const String refreshToken = 'refresh_token';

  // 인증 (로그인 & 회원가입) path
  static const String memberInsert = '/api/member/insert';
  static const String memberLogin = '/api/member/login';
  static const String memberLogout = '/api/member/logout';
  static const String memberRefresh = '/api/member/refresh';

  // 나무 정보 path
  static const String treeList = '/api/tree/tree_list';
  static const String treeCount = '/api/tree/count';
  static const String treeTile = '/api/tree/tile';

  // 메모리 정보 path
  static const String memoryTree = '/api/memory/tree';
  static const String memoryInsert = '/api/memory/insert';
  static const String memoryInsertWithTree = '/api/memory/insert_with_tree';
  static const String memeoryList = '/api/memory/list';
  static const String memoryWoodList = '/api/memory/wood_list';
  static const String memoryGuList = '/api/memory/gu_list';
  static const String memoryThemeList = '/api/memory/theme_list';
  static const String memoryWoodThemeList = '/api/memory/wood_theme_list';
}
