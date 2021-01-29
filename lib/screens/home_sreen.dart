import 'package:flutter/material.dart';
import 'package:mobile_desk/widgets/cart_button.dart';
import 'package:mobile_desk/widgets/categoriaChamados_tab.dart';
import 'package:mobile_desk/widgets/custom_drawer.dart';
import 'package:mobile_desk/widgets/home_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        //Home - Meus Chamados
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Chamados"),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          //floatingActionButton: CartButton(),
          ),
        //Novo Chamado
        Scaffold(
          appBar: AppBar(
            title: Text("Novo Chamado"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoriaChamados(),
          floatingActionButton: CartButton(),
        ),
      ],
    );
  }
}
