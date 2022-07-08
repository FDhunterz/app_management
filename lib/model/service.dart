class Memory {
  int available, total;
  double percentage;

  Memory({this.available = 0, this.percentage = 0, this.total = 0});
}

class App {
  String? packageName, name;

  App({this.name, this.packageName});
}

class Speed {
  double upload, download;

  Speed({this.upload = 0, this.download = 0});
}
