import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './dataSource.dart';

class DataSourceProvider extends InheritedWidget with ChangeNotifier {
  final dataSource data;

  DataSourceProvider({Key key, this.data, Widget child})
      : super(key: key, child: child);

  //region InheritedWidget implementation
  static DataSourceProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataSourceProvider>();
  }

  @override
  bool updateShouldNotify(DataSourceProvider old) => false;
//endregion
}

