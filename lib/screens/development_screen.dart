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
    // Adicione mais meses conforme necessário
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
