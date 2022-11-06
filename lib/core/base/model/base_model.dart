abstract class BaseModel<T> {
  BaseModel();

  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
