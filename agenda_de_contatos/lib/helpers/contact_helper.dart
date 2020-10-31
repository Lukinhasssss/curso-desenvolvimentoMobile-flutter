import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Declarando as variáveis que serão os nomes das colunas da tabela
final String contactTable = 'contactTable';
final String idColumn = 'idColumn'; // final é para deixar o valor como se fosse uma constante pois ele não irá mudar
final String nameColumn = 'nameColumn';
final String emailColumn = 'emailColumn';
final String phoneColumn = 'phoneColumn';
final String imgColumn = 'imgColumn';


class ContactHelper { // Essa é uma classe que não poderá ter várias instâncias ao longo do código e por isso será utilizado o Design Patter: Singleton

  static final ContactHelper _instance = ContactHelper.internal(); // static define a variável como sendo somente da classe

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  // Declarando o banco de dados
  Database _db; // O _ é para que o banco de dados não possa ser acessado de fora da minha classe

  // Inicializando o banco de dados
  Future<Database> get db async {
    if (_db != null) { // Se o banco de dados já estiver sido inicializado...
      return _db;
    } else { // Será preciso inicializar o banco de dados
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    // Primeiramente é preciso pegar o local onde o banco de dados é armazenado
    final databasesPath = await getDatabasesPath(); // Pega o caminho para a pasta onde armazeno meus bancos de dados

    // Agora é preciso pegar o arquivo que estará armazenando no meu banco de dados
    final path = join(databasesPath, 'contacts.db'); // Junta o caminho com o nome do meu banco e armazena em path

    // Agora é preciso abrir o banco de dados
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        'CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)'
      );
    });
  }


  // Criando função para salvar um contato. Essa função vai receber o contato que eu quero salvar
  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  // Criando função para obter os dados de um contato. Essa função vai receber o id do contato que eu quero obter
  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: '$idColumn = ?',
      whereArgs: [id]
    );
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Criando função para deletar um contato. Essa função vai receber o id do contato que eu quero deletar
  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete( // O delete retorna um número inteiro indicando se a exclusão deu certo e por isso o Future irá retornar um número inteiro
      contactTable,
      where: '$idColumn = ?',
      whereArgs: [id]
    );
  }

  // Criando função para atualizar um contato. Essa função vai receber o contato que eu quero atualizar
  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update( // O update também retorna um inteiro indicando se foi sucesso ou não
      contactTable,
      contact.toMap(),
      where: '$idColumn = ?',
      whereArgs: [contact.id]
    );
  }

  // Criando função para obter todos os contatos.
  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery('SELECT * FROM $contactTable');
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  // Criando função para obter o número de contatos da minha lista
  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery('SELECT COUNT(*) FROM $contactTable'));
  }

  // Criando função para fechar o banco de dados
  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}

class Contact { // Classe que vai definir tudo o que meu contato irá armazenar
  int id;
  String name;
  String email;
  String phone;
  String img; // img é o local (url) onde a imagem está armazenada, por isso é uma String

// Adicionando um constructor vazio.
  Contact();

  Contact.fromMap(Map map) { // É um construtor chamado de fromMap que irá receber um map
    // Pegando os dados do contato a partir de um map
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  // Transformando os dados do contato em um map para que seja possível armazenar
  Map toMap() { // Função que retorna um Map
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)';
  }
}