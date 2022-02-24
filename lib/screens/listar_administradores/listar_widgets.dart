import 'package:convida/models/user.dart';
import 'package:convida/screens/DAO/events_requisitions.dart';
import 'package:convida/screens/cadastrar_administradores/cadatrar_widgets.dart';
import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFFF4933);

class ListAdmin extends StatefulWidget {
  const ListAdmin({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<ListAdmin> createState() => _ListAdminState();
}

class _ListAdminState extends State<ListAdmin> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const ImageIcon(
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
      body: FutureBuilder(
        future: getAllAdmins(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<User> allAdmins = snapshot.data;
          if (snapshot.data == null &&
          snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center, //centalizar
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
                Text('Buscando administradores')
              ],
            ),
          );
        }else if (snapshot.data == null){
            return Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Administradores não disponíveis. Recarregue a página",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
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
                final user = allAdmins[indice]; //insere na variável a transferência do índice da vez
                return Admin(user);
              },
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(//Botão de + do canto inferior direito da tela
          child: const Icon(Icons.add), onPressed: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const NewAdministrator(),
          ),
        );
          //  .then((newContact) => debugPrint('teste'.toString()));
      }
      ),
    );
  }
}


class Admin extends StatelessWidget {
  final User _admin;
  // ignore: use_key_in_widget_constructors
  const Admin(this._admin);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile( //listTitle representa um card/grid que irá envolver um conteúdo (uma caixinha)
        leading: const Icon(
            Icons.person,
            color: Colors.blueAccent,
            size: 50
        ),
        title: Text(_admin.name + " " + _admin.lastName),
        subtitle: Text(_admin.email),
        trailing: IconButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Atenção'),
                content: const Text('Você realmente deseja remover este administrador?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancelar'),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => removeAdmin(_admin.id),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.delete_forever, size: 36),
            color: const Color(0xFF255D83),
        ),
      ),
    );
  }
}



