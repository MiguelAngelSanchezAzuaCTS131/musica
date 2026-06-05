import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {

  final String clientId =
      '45b003a9e3164aa4992ddfc49afdd7a4';

  final String clientSecret =
      'a4d72a8d45134338ad187571203568ca';

  Future<String> getAccessToken() async {

    final response = await http.post(

      Uri.parse(
        'https://accounts.spotify.com/api/token',
      ),

      headers: {
        'Content-Type':
            'application/x-www-form-urlencoded',
      },

      body: {
        'grant_type': 'client_credentials',
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    print(response.body);

    final data = json.decode(response.body);

    return data['access_token'];
  }

  Future<List<dynamic>> searchSongs(
  String query,
) async {

  final token = await getAccessToken();

  print("TOKEN:");
  print(token);

  final encodedQuery =
      Uri.encodeComponent(query);

  final url =
      'https://api.spotify.com/v1/search?q=$encodedQuery&type=track&limit=10';

  print(url);

  final response = await http.get(

    Uri.parse(url),

    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print("STATUS CODE:");
  print(response.statusCode);

  print("BODY:");
  print(response.body);

  final data = json.decode(response.body);

  return data['tracks']['items'];
}
}