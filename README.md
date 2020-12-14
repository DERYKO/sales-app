# solutech_sat

Cross platform version of Solutech SAT rewritten in flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


## Bean Anotation
```dart
    part 'stock_point_bean.jorm.dart';

    @GenBean()
    class StockPointBean extends Bean<StockPoint> with _StockPointBean {
      StockPointBean(Adapter adapter) : super(adapter);
      final String tableName = 'stockpoints';
    }
```

## Generate beans
```
    flutter pub run build_runner build --delete-conflicting-outputs
```

## Generate icon
```
    flutter packages pub run flutter_launcher_icons:main
```
