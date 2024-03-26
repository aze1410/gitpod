class GitModel {
  final int id;
  final String name;
  final String fullName;
  final String ownerLogin;
  final String ownerAvatarUrl;
  final String description;
  final String htmlUrl;
  final int forksCount;
  final int openIssuesCount;
  final String language;
  final String licenseKey;
  final List<String> topics;
  final DateTime createdAt;
  final bool disabled; // Added field
  final int isOpenIssuesCount; // Added field

  GitModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.ownerLogin,
    required this.ownerAvatarUrl,
    required this.description,
    required this.htmlUrl,
    required this.forksCount,
    required this.openIssuesCount,
    required this.language,
    required this.licenseKey,
    required this.topics,
    required this.createdAt,
    required this.disabled,
    required this.isOpenIssuesCount,
  });

  factory GitModel.fromJson(Map<String, dynamic> json) {
    return GitModel(
      id: json['id'],
      name: json['name'] ?? "",
      fullName: json['full_name'] ?? "",
      ownerLogin: json['owner']?['login'] ?? "",
      ownerAvatarUrl: json['owner']?['avatar_url'] ?? "",
      description: json['description'] ?? "",
      htmlUrl: json['html_url'] ?? "",
      forksCount: json['forks_count'] ?? 0,
      openIssuesCount: json['open_issues_count'] ?? 0,
      language: json['language'] ?? "",
      licenseKey: json['license'] != null ? json['license']['key'] ?? "" : "",
      topics: List<String>.from(json['topics'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
      disabled: json['disabled'] ?? false,
      isOpenIssuesCount: json['open_issues_count'] ?? 0,
    );
  }
}
