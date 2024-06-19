
class Almodel {
    String? url;

    Almodel({this.url});

    Almodel.fromJson(Map<String, dynamic> json) {
        if(json["url"] is String) {
            url = json["url"];
        }
    }

    static List<Almodel> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => Almodel.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["url"] = url;
        return _data;
    }

    Almodel copyWith({
        String? url,
    }) => Almodel(
        url: url ?? this.url,
    );
}