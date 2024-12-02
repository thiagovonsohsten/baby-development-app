import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey = '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'; // Coloque sua chave de API diretamente aqui
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',  // Modelo GPT-3.5 Turbo
          'messages': [
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return 'Erro ao obter resposta da IA. Código: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao se comunicar com a API: $e';
    }
  }
}
