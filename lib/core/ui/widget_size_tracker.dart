import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class WidgetSizeTracker {
  
  final GlobalKey key;
  
  BehaviorSubject<Size> _size = BehaviorSubject<Size>.seeded(Size.zero);
  
  WidgetSizeTracker(this.key);
  
  Stream<Size> get size => _size.stream.distinct();
  
  void onBuild(BuildContext context) {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      final widgetSize = key.currentContext?.size ?? Size.zero;
      
      if (_size.value != widgetSize) {
        
        _size.add(widgetSize);
        
      }
      
    });
    
  }
  
  void dispose() {
    _size.close();
  }
  
}