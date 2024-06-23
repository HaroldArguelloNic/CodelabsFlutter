import 'package:flutter/material.dart';

//****************************************************************************************/

void main() {
  runApp(
    //******* implementacion de AppStateWidget en el arbol de widget */
    const AppStateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MiTienda',
        home: MyStoragePage(),
      )
    )
  );
}
//************************************************************************ */
//*********  Modelo de datos que almacena el estado de los Widget **********/

class AppState {
  const AppState({
    required this.productList,
    this.itemInCart = const {},
  });

  final List<String> productList;
  final Set<String> itemInCart;

   AppState copyWith({List<String>? productList, Set<String>? itemInCart}) =>
      AppState(
          productList: productList ?? this.productList,
          itemInCart: itemInCart ?? this.itemInCart);

}
//*************************************************************************** */
//************* InheritedWidget para manejar los estados *********************/
class AppStateScope extends InheritedWidget {
  const AppStateScope(this.data,{
    super.key,
    required super.child });

  final AppState data;  
  static AppState of(BuildContext context) {
    return context
    .dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }
  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
return oldWidget.data != data;   //actualizar el estado de los widget en escucha
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({super.key, required this.child});
  final Widget child;
  
  static AppStateWidgetState of(BuildContext contetx) {
    return contetx.findAncestorStateOfType<AppStateWidgetState>()!;
  }
  @override
 AppStateWidgetState createState() => AppStateWidgetState();

  }

class AppStateWidgetState extends State<AppStateWidget> {
  AppState _data = AppState(
    productList: Server.getProductList(),
  );

  void setProductList(List<String> productList){
    if(_data.productList != productList){
      setState(() {
        _data = _data.copyWith(productList: productList);
      });
    }
  }

  void addToCart(String id) {
    if(!_data.itemInCart.contains(id)){
      setState(() {
        final Set<String> newitemInCart =
         Set<String>.from(_data.itemInCart);
         newitemInCart.add(id);
        _data = _data.copyWith(itemInCart: newitemInCart);
      });
    }

  }
  void removeFromCart(String id) {
    if(_data.itemInCart.contains(id)){
      setState(() {
        final Set<String> newitemInCart =
         Set<String>.from(_data.itemInCart);
         newitemInCart.remove(id);
        _data = _data.copyWith(itemInCart: newitemInCart);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return AppStateScope(_data, child: widget.child,);

  }
}


//****************************************************************************************/
//*****************************  pantalla principal de la aplicacion *********************/
class MyStoragePage extends StatefulWidget {
  const MyStoragePage({super.key});
  @override
  MyStoragePageState createState() => MyStoragePageState();

}
class MyStoragePageState extends State<MyStoragePage> {

  bool _inSearch= false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  void _toggleSearch(BuildContext context){
    setState(() {
        _inSearch = !_inSearch;
      });
  _controller.clear();
  AppStateWidget.of(context).setProductList(Server.getProductList());

  }
  
  void _handleSearch(BuildContext context) {
    _focusNode.unfocus();
    final String filter = _controller.text;
    AppStateWidget.of(context).setProductList(Server.getProductList(filter:filter));
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network('$baseAssetURL/google-logo.png'),
            ),
            title: _inSearch
                ? TextField(
                    autofocus: true,
                    focusNode: _focusNode,
                    controller: _controller,
                    onSubmitted: (_) => _handleSearch(context),
                    decoration: InputDecoration(
                      hintText: 'Search Google Store',
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _handleSearch(context)),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _toggleSearch(context)),
                    ),
                  ): null,
            actions: [
              if(!_inSearch)
               IconButton(onPressed: ()=> _toggleSearch(context),
                icon: const Icon(Icons.search,color: Colors.black),
                ),
              const ShoppingCartIcon(),
            ],
            backgroundColor: Colors.white,
            pinned: true,
             
          ),
          const SliverToBoxAdapter(
            child: ProductListWidget(),   //llamado al widget que contiene la lista de productos
          )
        ],
      ),
    );
  }
}
//****************************************************************************************/
//*** Clase ShoppingCartIcon, muestra el icono del carrito con la cantidad de producto seleccionado */
  
class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final Set<String> itemInCart = AppStateScope.of(context).itemInCart;
    final bool hasPurchase = itemInCart.isNotEmpty;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: hasPurchase? 17.0 : 10.0),
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
        if(hasPurchase)
        Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            child: Text(
              itemInCart.length.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          )
        )
      ],
    );
  }
}

//****************************************************************************************/
//******************* widget que muestra la lista de productos en la pagina principal ****/

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});
 
  void _handleAddToCart(String id, BuildContext context) {  // funcion que agrega productos al carriro
    AppStateWidget.of(context).addToCart(id);    
  }

  void _handleRemoveFromCart(id, BuildContext context) {   //funcion que remueve productos del carrito
    AppStateWidget.of(context).removeFromCart(id);
  }

  Widget _buildProductTile(String id,BuildContext context ){
    return ProductTile(
      product: Server.getProductById(id),
      purchased: AppStateScope.of(context).itemInCart.contains(id),
      onAddToCart: ()=>_handleAddToCart(id, context),
      onRemoveFromCart: ()=> _handleRemoveFromCart(id, context),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      AppStateScope.of(context)
      .productList.map(
        (id) => _buildProductTile(id, context),
        ).toList(),
    );
  }  
}

class ProductTile extends StatelessWidget {
    const ProductTile({
    super.key,
    required this.product,
    required this.purchased,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    });

    final Product product;
    final bool purchased;
    final VoidCallback onAddToCart;
    final VoidCallback onRemoveFromCart;

 @override
  Widget build(BuildContext context) {
    Color getButtonColor(Set<WidgetState> states) {
      return purchased ? Colors.grey : Colors.black;
    }

    BorderSide getButtonSide(Set<WidgetState> states) {
      return BorderSide(
        color: purchased ? Colors.grey : Colors.black,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 40,
      ),
      color: const Color(0xfff8f8f8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(product.title),
          ),
          Text.rich(
            product.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: OutlinedButton(
              style: ButtonStyle(
                foregroundColor:
                    WidgetStateProperty.resolveWith(getButtonColor),
                side: WidgetStateProperty.resolveWith(getButtonSide),
              ),
              onPressed: purchased ? onRemoveFromCart : onAddToCart,//llamada a la funcion agregar o remover del carrito
              child: purchased
                  ? const Text('Remove from cart')
                  : const Text('Add to cart'),
            ),
          ),
          Image.network(product.pictureURL),
        ],
      ),
    );
  }
}


const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/inherited_widget/assets';

const Map<String, Product> kDummyData = {
  '0': Product(
    id: '0',
    title: 'Explore Pixel phones',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Capture the details.\n',
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: 'Capture your world.',
        style: TextStyle(color: Colors.blue),
      ),
    ]),
    pictureURL: '$baseAssetURL/pixels.png',
  ),
  '1': Product(
    id: '1',
    title: 'Nest Audio',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Amazing sound.\n', style: TextStyle(color: Colors.green)),
      TextSpan(text: 'At your command.', style: TextStyle(color: Colors.black)),
    ]),
    pictureURL: '$baseAssetURL/nest.png',
  ),
  '2': Product(
    id: '2',
    title: 'Nest Audio Entertainment packages',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Built for music.\n',
        style: TextStyle(color: Colors.orange),
      ),
      TextSpan(
        text: 'Made for you.',
        style: TextStyle(color: Colors.black),
      ),
    ]),
    pictureURL: '$baseAssetURL/nest-audio-packages.png',
  ),
  '3': Product(
    id: '3',
    title: 'Nest Home Security packages',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Your home,\n', style: TextStyle(color: Colors.black)),
      TextSpan(text: 'safe and sound.', style: TextStyle(color: Colors.red)),
    ]),
    pictureURL: '$baseAssetURL/nest-home-packages.png',
  ),
};


//******************* Clase servidor que proporciona lista de productos */

class Server {
  static Product getProductById(String id) {
    return kDummyData[id]!;
  }

  static List<String> getProductList({String? filter}) {
    if (filter == null) return kDummyData.keys.toList();
    final List<String> ids = <String>[];
    for (final Product product in kDummyData.values) {
      if (product.title.toLowerCase().contains(filter.toLowerCase())) {
        ids.add(product.id);
      }
    }
    return ids;
  }
}

class Product {
  const Product({
    required this.id,
    required this.pictureURL,
    required this.title,
    required this.description,
  });

  final String id;
  final String pictureURL;
  final String title;
  final TextSpan description;
}