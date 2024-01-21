class ApiPaginationModel
{
  late int currentPage;
  late int fromPage;
  late int lastPage;
  late int toPage;
  late int perPage;
  late int total;
  late String? nextPageUrl;
  late String? prevPageUrl;
  late String? lastPageUrl;

  ApiPaginationModel.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'] ?? 1;
    fromPage    = json['from'] ?? 1;
    lastPage    = json['last_page'] ?? 1;
    toPage      = json['to'] ?? 1;
    perPage     = json['per_page'] ?? 1;
    total       = json['total'] ?? 1;
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    lastPageUrl = json['last_page_url'];
  }


}