import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// void main() {
//   runApp(new Center(
//     child: new Text(
//       'hello world',
//       textDirection: TextDirection.ltr,
//     ),
//   ));
// }

// class MyAppBar extends StatelessWidget {
//   MyAppBar({this.title});
//   final Widget title;

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       height: 120,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: new BoxDecoration(color: Colors.blue[500]),
//       //Row是水平方向的现行布局
//       child: new Row(
//         //列表项的类型是<Widget>
//         children: <Widget>[
//           new IconButton(
//             icon: new Icon(Icons.menu),
//             tooltip: 'Navigation menu',
//             onPressed: null,
//           ),
//           new Expanded(
//             child: title,
//           ),
//           new IconButton(
//             icon: new Icon(Icons.search),
//             tooltip: 'search',
//             onPressed: null,
//           )
//         ],
//       ),
//     );
//   }
// }

// class MyScaffold extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //Material 是UI呈现的纸
//     return new Material(
//       //column 是垂直方向的线性布局
//       child: new Column(
//         children: <Widget>[
//           new MyAppBar(
//             title: new Text(
//               'example title',
//               style: Theme.of(context).primaryTextTheme.title,
//             ),
//           ),
//           new Expanded(
//             child: new Center(
//               child: new Text('hello world'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(new MaterialApp(
//     title: 'my app',
//     home: new MyScaffold(),
//   ));
// }

// void main() {
//   runApp(new MaterialApp(
//     title: 'flutter tutorial',
//     home: new TutorialHome(),
//   ));
// }

// class TutorialHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //scaffold 是material 中的重要布局组件
//     return new Scaffold(
//       appBar: new AppBar(
//         leading: new IconButton(
//           icon: new Icon(Icons.menu),
//           onPressed: null,
//           tooltip: 'navigation menu',
//         ),
//         title: new Text('exemple title'),
//         actions: <Widget>[
//           new IconButton(
//               icon: new Icon(Icons.search), onPressed: null, tooltip: 'search'),
//         ],
//       ),
//       body: new Center(
//         child: new Counter(),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: null,
//         tooltip: 'add',
//         child: new Icon(Icons.add),
//       ),
//     );
//   }
// }

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new GestureDetector(
//       onTap: () {
//         print('按钮点击');
//       },
//       child: new Container(
//         height: 36,
//         padding: const EdgeInsets.all(8),
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: new BoxDecoration(
//           borderRadius: new BorderRadius.circular(5),
//           color: Colors.lightGreen[500],
//         ),
//         child: new Center(
//           child: new Text('engate'),
//         ),
//       ),
//     );
//   }
// }

//状态组件
// class Counter extends StatefulWidget {
//   @override
//   _ConterState createState() => new _ConterState();
// }

// class _ConterState extends State<Counter> {
//   int _counter = 0;

//   void _increment() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Row(
//       children: <Widget>[
//         new RaisedButton(
//           onPressed: _increment,
//           child: new Text('Incremet'),
//         ),
//         new Text('Count: $_counter'),
//       ],
//     );
//   }
// }

// class CounterDisplay extends StatelessWidget {
//   CounterDisplay({this.count});

//   final int count;

//   @override
//   Widget build(BuildContext context) {
//     return new Text('conut : $count');
//   }
// }

// class CounterIncrementor extends StatelessWidget {
//   CounterIncrementor({this.onPressed});

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return new RaisedButton(
//       onPressed: onPressed,
//       child: new Text('Increment'),
//     );
//   }
// }

// class Counter extends StatefulWidget {
//   @override
//   _CounterState createState() => new _CounterState();
// }

// class _CounterState extends State<Counter> {
//   int _counter = 0;

//   void _increment() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Row(children: <Widget>[
//       new CounterIncrementor(onPressed: _increment),
//       new CounterDisplay(
//         count: _counter,
//       )
//     ]);
//   }
// }

class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangeCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangeCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Shopping app',
    home: new ShoppingList(
      products: <Product>[
        new Product(name: '鸡蛋'),
        new Product(name: '牛奶'),
        new Product(name: '黄瓜'),
      ],
    ),
  ));
}
