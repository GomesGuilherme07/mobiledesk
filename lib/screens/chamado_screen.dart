import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/models/cart_chamado.dart';
import 'package:mobile_desk/models/cart_model.dart';
import 'package:mobile_desk/models/chamado_data.dart';
import 'package:mobile_desk/models/user_model.dart';
import 'package:mobile_desk/screens/cart_screen.dart';
import 'package:mobile_desk/screens/login_sreen.dart';

class ChamadoScreen extends StatefulWidget {

  final ChamadoData chamado;
  ChamadoScreen(this.chamado);

  @override
  _ChamadoScreenState createState() => _ChamadoScreenState(chamado);
}

class _ChamadoScreenState extends State<ChamadoScreen> {

  final ChamadoData chamado;
  String dispositivo;

  _ChamadoScreenState(this.chamado);

  @override
  Widget build(BuildContext context) {

    final Color _primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(chamado.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Image.network(chamado.img)
            ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(chamado.title, style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: _primaryColor
                ),),
                Text(chamado.descricao, style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                  maxLines: 3,
                ),
                SizedBox(height: 16.0,),
                Text("Selecione o tipo de dispositivo afetado: ", style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),),
                SizedBox(height: 10.0,),
                // Seleção do recurso/ dispositivo afetado
                SizedBox(
                  height: 50.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: chamado.dispositivo.map(
                        (d){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                dispositivo = d;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                  color: d == dispositivo ? _primaryColor : Colors.grey[700],
                                  width: 2.0
                                )
                              ),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(d),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                // Botão de confirmar
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: dispositivo != null ?
                    (){
                      if(UserModel.of(context).isLoggedIn()){
                        // Adicionar ao carrinho

                        CartChamado cartChamado = CartChamado();
                        cartChamado.dispositivo = dispositivo;
                        cartChamado.pid = chamado.id;
                        cartChamado.category = chamado.categoria;
                        cartChamado.chamadoData = chamado;

                        CartModel.of(context).addCartItem(cartChamado);

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> CartScreen())
                        );

                      }
                      else{
                        // Tela de Login
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Confirmar"
                      : "Entre para abrir o chamado",
                      style: TextStyle(fontSize: 18.0),),
                    color: _primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),

              ],
            ),
          )
        ],
      ),
    );
  }
}
