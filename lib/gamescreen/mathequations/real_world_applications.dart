import 'package:flutter/material.dart';
import 'analytics_engine.dart';

class RealWorldApplications extends StatefulWidget {
  const RealWorldApplications({Key? key}) : super(key: key);

  @override
  _RealWorldApplicationsState createState() => _RealWorldApplicationsState();
}

class _RealWorldApplicationsState extends State<RealWorldApplications> {
  bool isSpanish = false;

  final Map<String, String> englishText = {
    'title': 'Real-world Applications of Equations',
    'content':
        'Equations are used across many fields such as physics, engineering, and economics to model and solve real-world issues, from designing bridges to developing financial models.',
    'applicationsTitle': 'Some specific applications include:',
    'physics':
        'Physics: Newton\'s laws of motion, Maxwell\'s equations, Einstein\'s equations',
    'economics':
        'Economics: Modeling economic systems, analyzing market trends, financial predictions',
    'computerScience':
        'Computer Science: Algorithms, data analysis, cryptography',
    'statistics':
        'Statistics: Statistical analysis, probability theory, data-based decisions',
    'biology':
        'Biology: Modeling biological systems, understanding genetics, ecological analysis',
    'finance':
        'Finance: Pricing financial instruments, risk management, financial analysis',
    'medicine': 'Medicine: Medical imaging, pharmacokinetics, disease modeling',
  };

  final Map<String, String> spanishText = {
    'title': 'Aplicaciones en el Mundo Real de las Ecuaciones',
    'content':
        'Las ecuaciones se utilizan en muchos campos como la física, la ingeniería y la economía para modelar y resolver problemas del mundo real, desde el diseño de puentes hasta el desarrollo de modelos financieros.',
    'applicationsTitle': 'Algunas aplicaciones específicas incluyen:',
    'physics':
        'Física: Leyes del movimiento de Newton, ecuaciones de Maxwell, ecuaciones de Einstein',
    'economics':
        'Economía: Modelado de sistemas económicos, análisis de tendencias del mercado, predicciones financieras',
    'computerScience':
        'Informática: Algoritmos, análisis de datos, criptografía',
    'statistics':
        'Estadísticas: Análisis estadístico, teoría de la probabilidad, decisiones basadas en datos',
    'biology':
        'Biología: Modelado de sistemas biológicos, comprensión de la genética, análisis ecológico',
    'finance':
        'Finanzas: Valoración de instrumentos financieros, gestión de riesgos, análisis financiero',
    'medicine':
        'Medicina: Imágenes médicas, farmacocinética, modelado de enfermedades',
  };

  @override
  Widget build(BuildContext context) {
    final text = isSpanish ? spanishText : englishText;

    return Scaffold(
      appBar: AppBar(
        title: Text(text['title']!),
        actions: [
          TextButton.icon(
            icon: Icon(
              IconData(0xe67b,
                  fontFamily: 'MaterialIcons'), // Custom icon for translation
              color: isSpanish
                  ? Colors.blue
                  : Colors.red, // Change icon color based on language
            ),
            label: Text(
              isSpanish ? 'Español' : 'English',
              style: TextStyle(
                color: isSpanish ? Colors.blue : Colors.red,
              ),
            ),
            onPressed: () {
              setState(() {
                isSpanish = !isSpanish;
              });
              AnalyticsEngine.logTranslateButtonClickLearn(
                  isSpanish ? 'Changed to Spanish' : 'Changed to English');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Card(
                elevation: 8,
                color: const Color(0xFFFFEFD2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text['content']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        text['applicationsTitle']!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['physics']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['economics']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['computerScience']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['statistics']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['biology']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['finance']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text['medicine']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
