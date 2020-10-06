class DataKota {
  int success;
  Map<String, dynamic> data;
  String message;

  DataKota({this.success, this.data, this.message});

  factory DataKota.fromJson(Map<String, dynamic> json) {
    return DataKota(
      success: json['success'],
      data: json['data'],
      message: json['message']
    );
  }
}