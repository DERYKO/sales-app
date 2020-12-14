import 'dart:async';

class Manager {
  StreamController<dynamic> _controller = StreamController<dynamic>.broadcast();
  Stream<dynamic> get stream => _controller.stream;
  bool isLoading = false;

  void notifyChanges() {
    _controller.add(1);
  }

  void showLoader(bool show) {
    isLoading = show;
    notifyChanges();
  }

  void init() async {}

  void destroy() async {
    _controller.close();
  }
}
