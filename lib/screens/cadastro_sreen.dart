import 'package:flutter/material.dart';
import 'package:mobile_desk/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("CRIAR CONTA"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[

                  // campo nome
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    validator: (text){
                      if(text.isEmpty) return "Nome inválido!";
                    },
                  ),

                  SizedBox(height: 16.0,),

                  // campo email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                    },
                  ),

                  SizedBox(height: 16.0,),


                  // campo senha
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida";
                    },
                  ),

                  SizedBox(height: 16.0,),

                  // campo telefone
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(hintText: "Telefone"),
                    keyboardType: TextInputType.number,
                    validator: (text){
                      if(text.isEmpty) return "Telefone inválido";
                    },
                  ),

                  SizedBox(height: 16.0,),

                  // botao cadastrar
                  SizedBox(height: 44.0,
                    child: RaisedButton(
                      child: Text("Cadastrar",
                        style: TextStyle(
                            fontSize: 18.0
                        ),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "phone": _phoneController.text
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
                      },
                    ),)
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Cadastro realizado com sucesso !!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário !!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}




