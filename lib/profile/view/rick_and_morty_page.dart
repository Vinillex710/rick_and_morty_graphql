import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RickAndMortyPage extends StatefulWidget {
  const RickAndMortyPage({super.key});

  @override
  State<RickAndMortyPage> createState() => _RickAndMortyPageState();
}

class _RickAndMortyPageState extends State<RickAndMortyPage> {
  final query = '''
    query {
      characters(page:1){
        results{
          name
          species
          gender
          image
        }
      }
    }''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql(query),
          pollInterval: const Duration(seconds: 10),
        ),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(
              child:  Text('Loading'),
            );
          }
          
          final repositories = result.data!['characters']['results'] as List?;

          if (repositories == null) {
            return const Text('No repositories');
          }

          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];
              return ListTile(
                title: Text(repository['name'] as String ?? ''),
                subtitle: Text(repository['species'] as String ?? ''),
                trailing: Text(repository['gender'] as String ?? ''),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(repository['image'] as String),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
