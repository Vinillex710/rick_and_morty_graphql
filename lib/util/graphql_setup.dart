import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlSetup {
  late GraphQLClient client;

  Future<void> init() async {
    await initHiveForFlutter();

    final httpLink = HttpLink(
      'https://rickandmortyapi.com/graphql',
    );



    final link = httpLink;

    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  QueryHookResult<Object?> getRequest(String readRepositories) {
    final readRespositoriesResult = useQuery(
      QueryOptions(
        document:
            gql(readRepositories), 
        pollInterval: const Duration(seconds: 10),
      ),
    );
    return readRespositoriesResult;
  }

  MutationHookResult<Object?> getMutation(String addStar) {
    final addStarResult = useMutation(
      MutationOptions(
        document: gql(addStar),
      ),
    );
    return addStarResult;
  }

  
}
