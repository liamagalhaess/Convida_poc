import 'package:convida/models/user.dart';
import 'package:convida/screens/DAO/events_requisitions.dart';
import 'package:flutter/material.dart';


const Color kPrimaryColor = Color(0xFFFF4933);

class NewAdministrator extends StatefulWidget {
  const NewAdministrator({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<NewAdministrator> createState() => _NewAdministratorState();
}

class _NewAdministratorState extends State<NewAdministrator> {
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
      body: Container(
        child: FutureBuilder(
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
                      Text('Buscando usuários')
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
                            "Usuários não disponíveis. Recarregue a página",
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
                    final pessoa = allAdmins[indice]; //insere na variável a transferência do índice da vez
                    return NewAdmin(pessoa);
                  },
                );
              }
            }
        ),
      ),
    );
  }
}

class NewAdmin extends StatelessWidget {
  final User _admin;
  // ignore: use_key_in_widget_constructors
  const NewAdmin(this._admin);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile( //listTitle representa um card/grid que irá envolver um conteúdo (uma caixinha)
        leading: const Icon(
            Icons.person,
            color: Color(0xFF255D83),
            size: 55
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
          icon: const Icon(
            Icons.group_add_outlined,
            size: 42,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}



