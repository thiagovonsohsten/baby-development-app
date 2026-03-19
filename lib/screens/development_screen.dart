import 'package:flutter/material.dart';

class DevelopmentScreen extends StatelessWidget {
  final List<Map<String, String>> developmentStages = [
    {
      'month': '1',
      'info': 'No primeiro mês, os bebês começam a reconhecer a voz da mãe.',
      'details': 'Nesta fase, o bebê se acostuma ao mundo fora do útero. Ele começa a reconhecer a voz dos pais e pode dormir por longos períodos. É importante estimular o contato visual e falar com ele frequentemente.'
    },
    {
      'month': '2',
      'info': 'Começam a focar nos rostos e seguem objetos com os olhos.',
      'details': 'Os bebês começam a sorrir de forma responsiva e podem levantar a cabeça por curtos períodos. Brinquedos visuais são interessantes para estimular o foco do bebê.'
    },
    {
      'month': '3',
      'info': 'Os bebês começam a sustentar a cabeça e sorriem de forma responsiva.',
      'details': 'Com três meses, o bebê pode começar a emitir sons e balbuciar. Eles também começam a explorar as mãos e a abrir os punhos. É importante oferecer brinquedos seguros para essa exploração.'
    },
    {
      'month': '4',
      'info': 'Rola de lado e interage mais com sons e pessoas.',
      'details': 'O bebê começa a dar risadas, pegar objetos e levar as mãos à boca. Brincadeiras com voz e expressão facial ajudam no vínculo.'
    },
    {
      'month': '5',
      'info': 'Melhora o controle do tronco e do pescoço.',
      'details': 'Pode tentar sentar com apoio e demonstra curiosidade por brinquedos. Estimule com brinquedos coloridos e música suave.'
    },
    {
      'month': '6',
      'info': 'Senta com apoio e inicia introdução alimentar.',
      'details': 'Nesta fase, muitos bebês começam novos alimentos (com orientação pediátrica). O sono e a rotina ficam mais previsíveis.'
    },
    {
      'month': '7',
      'info': 'Explora objetos com as duas mãos.',
      'details': 'O bebê pode sentar com mais firmeza e reagir ao próprio nome. Conversar e cantar diariamente apoia a linguagem.'
    },
    {
      'month': '8',
      'info': 'Pode começar a engatinhar.',
      'details': 'A mobilidade aumenta e a casa precisa de mais segurança. É comum maior apego aos cuidadores.'
    },
    {
      'month': '9',
      'info': 'Entende comandos simples e imita sons.',
      'details': 'Brincadeiras de esconder e achar ajudam o desenvolvimento cognitivo. Incentive movimentos com segurança.'
    },
    {
      'month': '10',
      'info': 'Fica em pé com apoio e aponta objetos.',
      'details': 'O bebê mostra preferências e comunica vontades com gestos. Continue oferecendo rotina e estímulos.'
    },
    {
      'month': '11',
      'info': 'Dá passinhos com apoio.',
      'details': 'A coordenação motora evolui rapidamente. Jogos simples e leitura de livros com figuras são ótimos.'
    },
    {
      'month': '12',
      'info': 'Primeiro ano: pode andar e falar palavras simples.',
      'details': 'Nesta etapa, o bebê já participa mais da rotina da família. Reforçar limites com afeto é importante.'
    },
    {
      'month': '13-15',
      'info': 'Anda melhor e amplia o vocabulário.',
      'details': 'A criança entende frases simples e demonstra autonomia. Incentive brincadeiras motoras e leitura diária.'
    },
    {
      'month': '16-18',
      'info': 'Começa a nomear pessoas e objetos comuns.',
      'details': 'Nesta fase, a criança pode apresentar birras por frustração. Manter rotina consistente ajuda na regulação emocional.'
    },
    {
      'month': '19-21',
      'info': 'Combina palavras e imita atividades dos adultos.',
      'details': 'Brincadeiras simbólicas (como dar comida à boneca) surgem com mais frequência. Estimule com atividades simples.'
    },
    {
      'month': '22-24',
      'info': 'Melhora fala, coordenação e interação social.',
      'details': 'Com cerca de 2 anos, a criança já entende instruções curtas e participa de brincadeiras com outras crianças.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC), // Azul bebê
        title: Text(
          'Desenvolvimento Mês a Mês',
          style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: developmentStages.length,
        itemBuilder: (context, index) {
          final stage = developmentStages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFF8BBD0), // Rosa claro
                  child: Text(
                    stage['month']!,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  'Mês ${stage['month']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    stage['info']!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF616161)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DevelopmentDetailScreen(
                        month: stage['month']!,
                        details: stage['details']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class DevelopmentDetailScreen extends StatelessWidget {
  final String month;
  final String details;

  DevelopmentDetailScreen({required this.month, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC), // Azul bebê
        title: Text(
          'Detalhes do Mês $month',
          style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Desenvolvimento no Mês $month',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              details,
              style: TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF616161)),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
