import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_setup/profile/view/rick_and_morty_page.dart';

class App extends StatelessWidget {
  
  App({super.key});

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('https://rickandmortyapi.com/graphql/'),
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return  GraphQLProvider(
    client: client,
    child:  MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      home: const RickAndMortyPage(),
    ),
  );
    
  }
}
