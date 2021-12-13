
import 'package:convida/models/user.dart';
import 'package:convida/screens/DAO/events_requisitions.dart';
import 'package:flutter/material.dart';


const Color kPrimaryColor = Color(0xFFFF4933);

class ListarAdministradores extends StatefulWidget {
  const ListarAdministradores({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<ListarAdministradores> createState() => _ListarAdministradoresState();
}

class _ListarAdministradoresState extends State<ListarAdministradores> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(
              AssetImage('assets/icons/menu.png'),
              color: Color.fromRGBO(255, 73, 51, 1),
              size: 32,
            ),
            onPressed: () => {},
          );
        },
        ),
        title:
        Image.asset("assets/logos/logo-ufprconvida.png", scale: 16),
        //actions: getActions(currentIndex),
      ),
      body: Container(
        child: FutureBuilder(
          future: getAllAdms(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<User> allAdmins = snapshot.data;
            if (snapshot.data == null &&
            snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }else if (snapshot.data == null){
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Administradores não disponíveis. Recarregue a página",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ]
            ),

            );
            }
            else{
              return ListView.builder(//Percorrer lista de objetos dinamicamente
                itemCount: allAdmins.length, //Descobre o tamanho da lista
                itemBuilder: (context, indice){ //recebe um contexto e o índice do elemento
                  final pessoa = allAdmins[indice]; //insere na variável a transferência do índice da vez
                  return Adm(pessoa);
                },
              );
            }
          }
        ),
      ),

      floatingActionButton: FloatingActionButton(//Botão de + do canto inferior direito da tela
          child: Icon(Icons.add), onPressed: () {}
      ),
    );
  }
}
//




class Adm extends StatelessWidget {

  final User _adms;

  Adm(this._adms);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile( //listTitle representa um card/grid que irá envolver um conteúdo (uma caixinha)
        leading: Icon(
            Icons.person,
            color: Colors.blueAccent,
            size: 50
        ),
        title: Text(_adms.name + " " + _adms.lastName),
        subtitle: Text(_adms.email),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete),
          iconSize: 35,
          color: Color(0xFF255D83),
        ),
      ),
    );
  }
}



