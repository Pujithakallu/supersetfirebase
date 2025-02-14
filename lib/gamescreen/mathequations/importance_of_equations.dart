import 'package:flutter/material.dart';
import 'analytics_engine.dart';
import '../../utils/util.dart';

class ImportanceOfEquations extends StatefulWidget {
  const ImportanceOfEquations({Key? key}) : super(key: key);

  @override
  _ImportanceOfEquationsState createState() => _ImportanceOfEquationsState();
}

class _ImportanceOfEquationsState extends State<ImportanceOfEquations> {
  bool isSpanish = false;

  final Map<String, String> englishText = {
    'title': 'Importance of Equations',
    'foundation':
        '- Foundation of Mathematics: Equations are a fundamental part of mathematics, forming the basis for more complex concepts and calculations.',
    'problemSolving':
        '- Problem-Solving Skills: Learning to solve equations enhances your problem-solving abilities, allowing you to tackle various types of mathematical problems.',
    'realWorld':
        '- Real-World Applications: Equations are used in everyday life, from calculating distances and expenses to understanding scientific phenomena.',
    'logicalThinking':
        '- Logical Thinking: Working with equations helps develop logical thinking and reasoning skills, which are valuable in many aspects of life and other subjects.',
    'predictivePower':
        '- Predictive Power: Equations enable us to predict outcomes and understand relationships between different variables, which is essential in science and engineering.',
    'higherEducation':
        '- Critical for Higher Education: Mastering equations is crucial for success in higher-level math courses and STEM (Science, Technology, Engineering, and Mathematics) fields.',
    'confidence':
        '- Boosts Confidence: Successfully solving equations boosts your confidence and encourages a positive attitude towards learning mathematics.',
  };

  final Map<String, String> spanishText = {
    'title': 'Importancia de las Ecuaciones',
    'foundation':
        '- Fundamento de las Matemáticas: Las ecuaciones son una parte fundamental de las matemáticas, formando la base para conceptos y cálculos más complejos.',
    'problemSolving':
        '- Habilidades para Resolver Problemas: Aprender a resolver ecuaciones mejora tus habilidades para resolver problemas, permitiéndote abordar varios tipos de problemas matemáticos.',
    'realWorld':
        '- Aplicaciones en el Mundo Real: Las ecuaciones se utilizan en la vida cotidiana, desde calcular distancias y gastos hasta comprender fenómenos científicos.',
    'logicalThinking':
        '- Pensamiento Lógico: Trabajar con ecuaciones ayuda a desarrollar habilidades de pensamiento lógico y razonamiento, que son valiosas en muchos aspectos de la vida y otras materias.',
    'predictivePower':
        '- Poder Predictivo: Las ecuaciones nos permiten predecir resultados y comprender las relaciones entre diferentes variables, lo cual es esencial en la ciencia y la ingeniería.',
    'higherEducation':
        '- Crítico para la Educación Superior: Dominar las ecuaciones es crucial para el éxito en cursos de matemáticas de nivel superior y campos STEM (Ciencia, Tecnología, Ingeniería y Matemáticas).',
    'confidence':
        '- Aumenta la Confianza: Resolver ecuaciones con éxito aumenta tu confianza y fomenta una actitud positiva hacia el aprendizaje de las matemáticas.',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding as needed
            child: IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Color(0xFF6C63FF),
                size: 26,
              ),
              onPressed: () => logout(context),
            ),
        ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Set the width to 80% of the screen width
            child: IntrinsicHeight(
              child: Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text['title']!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['foundation']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['problemSolving']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['realWorld']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['logicalThinking']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['predictivePower']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['higherEducation']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text['confidence']!,
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
