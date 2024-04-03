import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Pokemon {
  final String name;
  final String imageUrl;
  final String type;
  final double weight;
  final double height;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.weight,
    required this.height,
  });
}

class PokemonRegistrationScreen extends StatefulWidget {
  @override
  _PokemonRegistrationScreenState createState() => _PokemonRegistrationScreenState();
}

class _PokemonRegistrationScreenState extends State<PokemonRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _typeController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o nome do Pokémon';
    }
    return null;
  }

  String? _validateImageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a URL da imagem do Pokémon';
    }
    return null;
  }

  String? _validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o tipo do Pokémon';
    }
    return null;
  }

  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o peso do Pokémon';
    }
    return null;
  }

  String? _validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a altura do Pokémon';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, create Pokemon object
      Pokemon newPokemon = Pokemon(
        name: _nameController.text,
        imageUrl: _imageUrlController.text,
        type: _typeController.text,
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
      );

      // Show confirmation dialog
      showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação de Cadastro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: ${newPokemon.name}'),
              Image.network(newPokemon.imageUrl),
              Text('Tipo: ${newPokemon.type}'),
              Text('Peso: ${newPokemon.weight} kg'),
              Text('Altura: ${newPokemon.height} m'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome do Pokémon'),
                validator: _validateName,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                validator: _validateImageUrl,
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Tipo do Pokémon'),
                validator: _validateType,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                validator: _validateWeight,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Altura (m)'),
                validator: _validateHeight,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Cadastrar Pokémon'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonListScreen extends StatelessWidget {
  final List<Pokemon> pokemons;

  PokemonListScreen({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pokémons'),
      ),
      body: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(pokemons[index].imageUrl),
            title: Text(pokemons[index].name),
            subtitle: Text(pokemons[index].type),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailScreen(pokemon: pokemons[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonRegistrationScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl),
            SizedBox(height: 20),
            Text(
              'Nome: ${pokemon.name}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Tipo: ${pokemon.type}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Peso: ${pokemon.weight} kg',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Altura: ${pokemon.height} m',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final List<Pokemon> pokemons = [
    Pokemon(
      name: "Pikachu",
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
      type: "Electric",
      weight: 6.0,
      height: 0.4,
    ),
    Pokemon(
      name: "Bulbasaur",
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
      type: "Grass/Poison",
      weight: 6.9,
      height: 0.7,
    ),
    Pokemon(
      name: "Charmander",
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
      type: "Fire",
      weight: 8.5,
      height: 0.6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Pokémons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonListScreen(pokemons: pokemons),
    );
  }
}
