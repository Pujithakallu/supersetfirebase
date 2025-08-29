import 'package:flutter/material.dart';

final List<Map<String, dynamic>> shapes = [
  {
    'name': 'Lines',
    'icon': Icons.show_chart,
    'color': const Color(0xFFF76E11),
    'darkcolor': const Color(0xFFA3501D),
    'intro': {
      'definition': {
        'en': 'A line is a straight path that extends infinitely in both directions.',
        'es': 'Una línea es una trayectoria recta que se extiende infinitamente en ambas direcciones.'
      },
      'types': [
        {
          'title': {'en': 'Line', 'es': 'Línea Recta'},
          'description': {
            'en': 'It is a line that has no endpoints.',
            'es': 'Una línea que no tiene puntos finales.'
          },
          'image': {
            'en': 'assets/Mathgeometry/lines/line.png',
            'es': 'assets/Mathgeometry/lines/line_spanish.png'
          }
        },
        {
          'title': {'en': 'Ray', 'es': 'Rayo'},
          'description': {
            'en': 'A part of a line with one endpoint.',
            'es': 'Una parte de una línea con un punto final.'
          },
          'image': {
            'en': 'assets/Mathgeometry/lines/ray_learn.png',
            'es': 'assets/Mathgeometry/lines/ray_spanish.png'
          }
        },
        {
          'title': {'en': 'Line Segment', 'es': 'Segmento de Línea'},
          'description': {
            'en': 'A part of a line with two endpoints.',
            'es': 'Una parte de una línea con dos puntos finales.'
          },
          'image': {
            'en': 'assets/Mathgeometry/lines/segment_learn.png',
            'es': 'assets/Mathgeometry/lines/segment_spanish.png'
          }
        },
        {
          'title': {'en': 'Parallel Lines', 'es': 'Líneas Paralelas'},
          'description': {
            'en': 'Lines that never intersect.',
            'es': 'Líneas que nunca se intersecan.'
          },
          'image': {
            'en': 'assets/Mathgeometry/lines/parallel_lines.png',
            'es': 'assets/Mathgeometry/lines/parallel_lines_spanish.png'
          }
        },
        {
          'title': {'en': 'Perpendicular Lines', 'es': 'Líneas Perpendiculares'},
          'description': {
            'en': 'Lines that intersect at 90 degrees.',
            'es': 'Líneas que se intersecan en 90 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/lines/perpendicular_lines.png',
            'es': 'assets/Mathgeometry/lines/perpendiculat_lines_spanish.png'
          }
        },
        {
          'title': {'en': 'Intersecting Lines', 'es': 'Líneas de Intersección'},
          'description': {
            'en': 'Lines that intersect at a point.',
            'es': 'Líneas que se intersecan en un punto.'
          },
          'image': {
            'en': 'assets/Mathgeometry/lines/intersecting_lines.png',
            'es': 'assets/Mathgeometry/lines/intersecting_lines_spanish.png'
          }
        },
      ],
      'mainImage': {
        'en': 'assets/Mathgeometry/lines/line_all_new.png',
        'es': 'assets/Mathgeometry/lines/line_all_spanish.png'
      },
    },
    'practice': {
      'questions': [
        {
          'question': 
          {'en': 'What is a line?', 'es': '¿Qué es una línea?'},
          'answers': [
            {'text': {'en': 'A curve', 'es': 'Una curva'}, 'correct': false},
            {'text': {'en': 'A straight path', 'es': 'Un camino recto'}, 'correct': true},
            {'text': {'en': 'A circle', 'es': 'Un círculo'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a ray?', 'es': '¿Qué es un rayo?'},
          'answers': [
            {'text': {'en': 'Part of a line with two endpoints', 'es': 'Parte de una línea con dos puntos finales'}, 'correct': false},
            {'text': {'en': 'Part of a line with one endpoint', 'es': 'Parte de una línea con un punto final'}, 'correct': true},
            {'text': {'en': 'A straight path', 'es': 'Un camino recto'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a line segment?', 'es': '¿Qué es un segmento de línea?'},
          'answers': [
            {'text': {'en': 'Part of a line with one endpoint', 'es': 'Parte de una línea con un punto final'}, 'correct': false},
            {'text': {'en': 'Part of a line with two endpoints', 'es': 'Parte de una línea con dos puntos finales'}, 'correct': true},
            {'text': {'en': 'A straight path', 'es': 'Un camino recto'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which of the following statements is true?', 'es': '¿Cuál de las siguientes afirmaciones es correcta?'},
          'answers': [
            {'text': {'en': 'A ray has two endpoints.', 'es': 'Un rayo tiene dos puntos finales.'}, 'correct': false},
            {'text': {'en': 'A line segment has one endpoint.', 'es': 'Un segmento de línea tiene un punto final.'}, 'correct': false},
            {'text': {'en': 'A line has no endpoints.', 'es': 'Una línea no tiene puntos finales.'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'If two lines never meet and are always the same distance apart, what is their relationship?',
          'es': 'Si dos líneas nunca se encuentran y siempre están a la misma distancia, ¿cuál es su relación?'},
          'answers': [
            {'text': {'en': 'The lines are parallel', 'es': 'Las lineas son paralelas'}, 'correct': true},
            {'text': {'en': 'The lines are perpendicular', 'es': 'Las lineas son perpendiculares'}, 'correct': false},
            {'text': {'en': 'The lines are horizontal', 'es': 'Las líneas son horizontales'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'If two lines cross each other at a 90-degree angle, what type of lines are they?',
          'es': 'Si dos líneas se cruzan en un ángulo de 90 grados, ¿qué tipo de líneas son?'},
          'answers': [
            {'text': {'en': 'The lines are parallel', 'es': 'Las lineas son paralelas'}, 'correct': false},
            {'text': {'en': 'The lines are perpendicular', 'es': 'Las lineas son perpendiculares'}, 'correct': true},
            {'text': {'en': 'The lines are horizontal', 'es': 'Las líneas son horizontales'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Identify the line in this image.', 'es': 'Identifica la línea en esta imagen.'},
          'answers': [
            {'text': {'en': 'AB', 'es': 'AB'}, 'correct': true},
            {'text': {'en': 'AC', 'es': 'AC'}, 'correct': false},
            {'text': {'en': 'BC', 'es': 'BC'}, 'correct': false},
          ],
          'questionImage': 'assets/Mathgeometry/lines/P7.png',
        },
        {
          'question': 
          {'en': 'Which parts of this image represent rays?', 'es': '¿Qué partes de esta imagen representan rayos?'},
          'answers': [
            {'text': {'en': 'CB and CA', 'es': 'CB y CA'}, 'correct': true},
            {'text': {'en': 'AB and AC', 'es': 'AB y AC'}, 'correct': false},
            {'text': {'en': 'CB and AB', 'es': 'CB y AB'}, 'correct': true},
          ],
          'questionImage': 'assets/Mathgeometry/lines/P8.png',
        },
        {
          'question': 
          {'en': 'Which parts of this image represent a line segment?', 
          'es': '¿Qué partes de esta imagen representan un segmento de línea?'},
          'answers': [
            {'text': {'en': 'AB', 'es': 'AB'}, 'correct': false},
            {'text': {'en': 'DC', 'es': 'DC'}, 'correct': true},
            {'text': {'en': 'BC', 'es': 'BC'}, 'correct': false},
          ],
          'questionImage': 'assets/Mathgeometry/lines/P7.png',
        },
        {
          'question': 
          {'en': 'Which point is the endpoint of the ray, and in which direction does it extend?', 
          'es': '¿Cuál es el punto final del rayo y en qué dirección se extiende?'},
          'answers': [
            {'text': {'en': 'Endpoint A, extends right', 'es': 'Punto final A, se extiende hacia la derecha'}, 'correct': false},
            {'text': {'en': 'Endpoint B, extends right', 'es': 'Punto final B, se extiende hacia la derecha'}, 'correct': false},
            {'text': {'en': 'Endpoint A, extends left', 'es': 'Punto final A, se extiende hacia la izquierda'}, 'correct': true},
          ],
          'questionImage': 'assets/Mathgeometry/lines/P10.png',
        },
      ],
    },
    'quiz': {
      'questions': [
        {
          'question':
              {'en': 'You are standing at the edge of a straight road that extends as far as you can see. What is the best geometric representation of this road?',
              'es': 'Estás parado al borde de una carretera recta que se extiende hasta donde alcanza la vista. ¿Cuál es la mejor representación geométrica de esta carretera?'},
          'options': {'en': ['Line', 'Ray', 'Segment'], 'es': ['Línea', 'Rayo', 'Segmento']},
          'correctAnswer': {'en': 'Line', 'es': 'Línea'},
          'hint':  {'en': 'A road extends infinitely on both sides.', 'es': 'Un camino se extiende infinitamente por ambos lados.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq1.webp',
        },
        {
          'question':
              {'en': 'A flashlight is turned on in a dark room, emitting light in one direction. How can the path of light from the flashlight be represented?', 
              'es': 'Se enciende una linterna en una habitación oscura, emitiendo luz en una dirección. ¿Cómo se puede representar la trayectoria de la luz de la linterna?'},
          'options': {'en': ['Line', 'Ray', 'Segment'], 'es': ['Línea', 'Rayo', 'Segmento']},
          'correctAnswer': {'en': 'Ray', 'es': 'Rayo'}, 
          'hint':
              {'en': 'The flashlight itself is one endpoint and the light extends infinitely in the direction it is pointed.',
              'es': 'La linterna en sí es un punto final y la luz se extiende infinitamente en la dirección en la que se apunta.'}, 
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq2.jpg',
        },
        {
          'question':
              {'en': 'You are measuring the length of a wooden stick with a ruler. What geometric concept does the stick represent?', 
              'es': 'Estás midiendo la longitud de un palo de madera con una regla. ¿Qué concepto geométrico representa el palo?'},
          'options': {'en': ['Line', 'Ray', 'Segment'], 'es': ['Línea', 'Rayo', 'Segmento']},
          'correctAnswer': {'en': 'Segment', 'es': 'Segmento'},
          'hint': {'en': 'The wooden stick has two endpoints.', 'es': 'El palo de madera tiene dos extremos.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq3.jpg',
        },
        {
          'question':
              {'en': 'Two railroad tracks run side by side and never meet, no matter how far they extend. How are these tracks geometrically classified?', 
              'es': 'Dos vías de ferrocarril discurren una junto a la otra y nunca se encuentran, por mucho que se extiendan. ¿Cómo se clasifican geométricamente estas vías?'},
          'options': {'en': ['Perpendicular lines', 'Intersecting lines', 'Parallel line'], 'es': ['Líneas perpendiculares', 'Líneas que se intersecan', 'Líneas paralelas']},
          'correctAnswer': {'en': 'Parallel line', 'es': 'Línea paralela'},
          'hint': {'en': 'The railroads never meet.', 'es': 'Los ferrocarriles nunca se encuentran.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq4.jpg',
        },
        {
          'question':
              {'en': 'A flagpole stands upright on flat ground. The pole and the ground meet at a right angle. How can this arrangement be described geometrically?', 
              'es': 'Un asta de bandera se yergue sobre un terreno plano. El asta y el suelo se encuentran en ángulo recto. ¿Cómo se puede describir geométricamente esta disposición?'},
          'options': {'en': ['Parallel lines', 'Intersecting lines', 'Perpendicular lines'], 'es': ['Líneas paralelas', 'Líneas que se intersecan', 'Líneas perpendiculares']},
          'correctAnswer': {'en': 'Perpendicular lines', 'es': 'Líneas perpendiculares'},
          'hint': {'en': 'Angle formed between pole and ground is exactly 90 degrees.', 'es': 'El ángulo formado entre el poste y el suelo es exactamente 90 grados.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq5.jpg',
        },
        {
          'question':
              {'en': 'Two roads cross each other at an intersection but do not form right angles. What is the geometric relationship between these roads?', 
              'es': 'Dos caminos se cruzan en una intersección, pero no forman ángulos rectos. ¿Cuál es la relación geométrica entre estos caminos?'},
          'options': {'en': ['Parallel lines', 'Perpendicular lines', 'Intersecting lines'], 'es': ['Líneas paralelas', 'Líneas perpendiculares', 'Líneas que se intersecan']},
          'correctAnswer': {'en': 'Intersecting lines', 'es': 'Líneas que se cruzan'},
          'hint': {'en': 'Angle between the two roads is not 90 degrees.', 'es': 'El ángulo entre los dos caminos no es de 90 grados.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq6.jpg',
        },
        {
          'question':
              {'en': 'A basketball court has markings for the free throw lane. The sidelines of the court never touch, while the baseline and the sideline meet at a right angle. Which types of lines are the two sidelines and the sidelines and the baseline?', 
              'es': 'Una cancha de baloncesto tiene marcas para la línea de tiros libres. Las líneas laterales de la cancha nunca se tocan, mientras que la línea de fondo y la línea lateral se encuentran en ángulo recto. ¿Qué tipos de líneas son las dos líneas laterales y las líneas laterales y la línea de fondo?'},
          'options': {'en': 
          [
            'Parallel and Intersecting',
            'Parallel and Perpendicular',
            'Perpendicular and Intersecting'
          ], 
          'es': 
          [
            'Paralelas e intersecantes',
            'Paralelas y perpendiculares',
            'Perpendiculares e intersecantes'
          ]},
          'correctAnswer': {'en': 'Parallel and Perpendicular', 'es': 'Paralelas y perpendiculares'},
          'hint':
              {'en': 'The sidelines never meet. The baseline and sideline meet at a 90 degree angle.', 'es': 'Las líneas laterales nunca se tocan. La línea de fondo y la línea lateral se encuentran en un ángulo de 90 grados.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq7.webp',
        },
        {
          'question':
              {'en': 'A ladder leans against a wall. The wall is vertical, and the ground is horizontal. The ladder forms a triangle with the wall and the ground. Which two lines are perpendicular in this scenario?', 
              'es': 'Una escalera se apoya contra una pared. La pared es vertical y el suelo horizontal. La escalera forma un triángulo con la pared y el suelo. ¿Cuáles dos líneas son perpendiculares en este caso?'},
          'options': {'en': 
          [
            'The ladder and the wall',
            'The ladder and the ground',
            'The wall and the ground'
          ], 
          'es': 
          [
            'La escalera y el muro',
            'La escalera y el suelo',
            'El muro y el suelo'
          ]},
          'correctAnswer': {'en': 'The wall and the ground', 'es': 'El muro y el suelo'},
          'hint': {'en': 'The wall and the ground meet at a 90 degree angle.', 'es': 'La pared y el suelo se encuentran en un ángulo de 90 grados.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq8.jpg',
        },
        {
          'question':
              {'en': 'In a city grid system, the main street runs north-south, and cross streets run east-west. What is the relationship between the main street and any one of the cross streets?', 
              'es': 'En un sistema de cuadrícula urbana, la calle principal corre de norte a sur y las calles transversales de este a oeste. ¿Cuál es la relación entre la calle principal y cualquiera de las calles transversales?'},
          'options': {'en': ['Parallel lines', 'Perpendicular lines', 'Rays'], 'es': ['Líneas paralelas', 'Líneas perpendiculares', 'Rayos']},
          'correctAnswer': {'en': 'Perpendicular lines', 'es': 'Líneas perpendiculares'},
          'hint': {'en': 'The main street and cross streets meet at a 90 degree angle.', 'es': 'La calle principal y las calles transversales se encuentran en un ángulo de 90 grados.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq9.jpg',
        },
        {
          'question':
              {'en': 'You are driving on a highway with two lanes going in the same direction. These lanes run side by side without ever meeting. How can the geometric relationship between these lanes be described?', 
              'es': 'Conduces por una autopista con dos carriles en la misma dirección. Estos carriles discurren uno junto al otro sin cruzarse. ¿Cómo se puede describir la relación geométrica entre estos carriles?'},
          'options': {'en': ['Parallel lines', 'Perpendicular lines', 'Rays'], 'es': ['Líneas paralelas', 'Líneas perpendiculares', 'Rayos']},
          'correctAnswer': {'en': 'Parallel lines', 'es': 'Líneas paralelas'},
          'hint': {'en': 'The lanes never intersect.', 'es': 'Los carriles nunca se cruzan.'},
          'questionImage': 'assets/Mathgeometry/lines/quiz/lq10.jpg',
        },
      ],
    },
    'section': [
      {
        'title': 'Learn',
        'icon': Icons.book,
        'color': const Color(0xFFF76E11),
        'darkcolor': const Color(0xFFA3501D),
        'page': 'learn',
      },
      {
        'title': 'Practice',
        'icon': Icons.lightbulb_outline,
        'color': const Color(0xFFF76E11),
        'darkcolor': const Color(0xFFA3501D),
        'page': 'practice',
      },
      {
        'title': 'Quiz',
        'icon': Icons.question_answer_outlined,
        'color': const Color(0xFFF76E11),
        'darkcolor': const Color(0xFFA3501D),
        'page': 'quiz',
      },
    ],
  },
  {
    'name': 'Planes',
    'icon': Icons.view_stream,
    'color': const Color(0xFF09C4B0),
    'darkcolor': const Color(0xFF147E70),
    'intro': {
      'definition': {
        'en': 'A plane is a flat, two-dimensional surface that extends infinitely in all directions.',
        'es': 'Un plano es una superficie plana bidimensional que se extiende infinitamente en todas direcciones.'
      },
      'types': [
        {
          'title': {'en': 'Horizontal Plane', 'es': 'Plano Horizontal'},
          'description': {
            'en': 'A plane parallel to the horizon, like the surface of a table or floor.',
            'es': 'Un plano paralelo al horizonte, como la superficie de una mesa o el suelo.'
          },
          'image': {
            'en': 'assets/Mathgeometry/plane/Horizontal_E.png',
            'es': 'assets/Mathgeometry/plane/Horizontal_S.png'
          }
        },
        {
          'title': {'en': 'Vertical Plane', 'es': 'Plano Vertical'},
          'description': {
            'en': 'A plane perpendicular to the horizontal plane, such as a wall.',
            'es': 'Un plano perpendicular al plano horizontal, como una pared.'
          },
          'image': {
            'en': 'assets/Mathgeometry/plane/Vertical_E.png',
            'es': 'assets/Mathgeometry/plane/Vertical_S.png'
          }
        },
        {
          'title': {'en': 'Inclined Plane', 'es': 'Plano Inclinado'},
          'description': {
            'en': 'A plane at an angle to the horizontal, commonly known as a ramp.',
            'es': 'Un plano en ángulo con respecto al horizontal, conocido comúnmente como rampa.'
          },
          'image': {
            'en': 'assets/Mathgeometry/plane/Inclined_E.png',
            'es': 'assets/Mathgeometry/plane/Inclined_S.png'
          }
        },
      ],
      'mainImage': {
        'en': 'assets/Mathgeometry/plane/Plane_E.png',
        'es': 'assets/Mathgeometry/plane/Plane_S.png'
      },
    },
    'practice': {
      'questions': [
        {
          'question':
          {'en': 'What is a plane?', 
          'es': '¿Qué es un avión?'},
          'answers': [
            {'text': {'en': 'A flat, two-dimensional surface', 'es': 'Una superficie plana y bidimensional'}, 'correct': true},
            {'text': {'en': 'A three-dimensional shape', 'es': 'Una forma tridimensional'}, 'correct': false},
            {'text': {'en': 'A curved surface', 'es': 'Una superficie curva'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a horizontal plane?', 
          'es': '¿Qué es un plano horizontal?'},
          'answers': [
            {'text': {'en': 'A plane parallel to the horizon', 'es': 'Un plano paralelo al horizonte'}, 'correct': true},
            {'text': {'en': 'A plane perpendicular to the horizon', 'es': 'Un plano perpendicular al horizonte'}, 'correct': false},
            {'text': {'en': 'A slanted plane', 'es': 'Un plano inclinado'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a vertical plane?', 
          'es': '¿Qué es un plano vertical?'},
          'answers': [
            {'text': {'en': 'A plane parallel to the horizon', 'es': 'Un plano paralelo al horizonte'}, 'correct': false},
            {'text': {'en': 'A plane perpendicular to the horizon', 'es': 'Un plano perpendicular al horizonte'}, 'correct': true},
            {'text': {'en': 'A slanted plane', 'es': 'Un plano inclinado'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which of the following best describes an inclined plane?', 
          'es': '¿Cuál de las siguientes opciones describe mejor un plano inclinado?'},
          'answers': [
            {'text': {'en': 'A plane that curves upward', 'es': 'Un avión que se curva hacia arriba'}, 'correct': false},
            {'text': {'en': 'A flat surface at an angle to the ground', 'es': 'Una superficie plana en ángulo con respecto al suelo.'}, 'correct': true},
            {'text': {'en': 'A flat surface parallel to the ground', 'es': 'Una superficie plana paralela al suelo.'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which of these is an example of a horizontal plane in real life?', 
          'es': '¿Cuál de estos es un ejemplo de un plano horizontal en la vida real?'},
          'answers': [
            {'text': {'en': 'A wall', 'es': 'Una pared'}, 'correct': false},
            {'text': {'en': 'The surface of a table', 'es': 'La superficie de una mesa'}, 'correct': true},
            {'text': {'en': 'A ramp', 'es': 'Una rampa'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'True or False: A vertical plane is always parallel to the ground.', 
          'es': 'Verdadero o falso: Un plano vertical siempre es paralelo al suelo.'},
          'answers': [
            {'text': {'en': 'True', 'es': 'Verdadero'}, 'correct': false},
            {'text': {'en': 'False', 'es': 'Falso'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What are the types of planes?', 
          'es': '¿Cuales son los tipos de aviones?'},
          'answers': [
            {'text': {'en': 'Horizontal, vertical, inclined', 'es': 'Horizontal, vertical, inclinada'}, 'correct': true},
            {'text': {'en': 'Acute, obtuse, right', 'es': 'Agudo, obtuso, recto'}, 'correct': false},
            {'text': {'en': 'None of the above', 'es': 'Ninguna de las anteriores'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What angle does a vertical plane typically make with the ground?', 
          'es': '¿Qué ángulo forma típicamente un plano vertical con el suelo?'},
          'answers': [
            {'text': {'en': '45 degrees', 'es': '45 grados'}, 'correct': false},
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': true},
            {'text': {'en': '180 degrees', 'es': '180 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which of the following angles would an inclined plane make with the ground?', 
          'es': '¿Cuál de los siguientes ángulos formaría un plano inclinado con el suelo?'},
          'answers': [
            {'text': {'en': '45 degrees', 'es': '45 grados'}, 'correct': true},
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': false},
            {'text': {'en': '0 degrees', 'es': '0 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What angle does a horizontal plane typically make with the ground?', 
          'es': '¿Qué ángulo forma típicamente un plano horizontal con el suelo?'},
          'answers': [
            {'text': {'en': '45 degrees', 'es': '45 grados'}, 'correct': false},
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': false},
            {'text': {'en': '0 degrees', 'es': '0 grados'}, 'correct': true},
          ],
          'questionImage': '',
        },
      ],
    },
    'quiz': {
      'questions': [
        {
          'question':
              {'en': 'A construction worker is building a ramp for a wheelchair. The ramp is inclined at a 12° angle with the ground. What type of plane does the ramp represent?', 
              'es': 'Un obrero construye una rampa para una silla de ruedas. La rampa tiene una inclinación de 12° con respecto al suelo. ¿Qué tipo de plano representa la rampa?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Inclined plane', 'es': 'Plano inclinado'},
          'hint': {'en': 'This type of plane is sloped and helps objects move up or down gradually.', 'es': 'Este tipo de plano está inclinado y ayuda a que los objetos se muevan hacia arriba o hacia abajo gradualmente.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq1.jpg',
        },
        {
          'question':
              {'en': 'When an airplane takes off, it travels along a runway that is essentially a large flat surface. What type of plane is the runway considered to be?', 
              'es': 'Cuando un avión despega, recorre una pista que es esencialmente una gran superficie plana. ¿Qué tipo de avión se considera una pista?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Horizontal plane', 'es': 'Plano horizontal'},
          'hint': {'en': 'This type of plane is flat and level with the ground.', 'es': 'Este tipo de avión es plano y nivelado con el suelo.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq2.jpg',
        },
        {
          'question':
              {'en': 'A large sliding door in a building is mounted vertically and opens by sliding along the wall. What type of plane is the sliding door mounted on?', 
              'es': 'Una puerta corredera grande en un edificio está montada verticalmente y se abre deslizándose por la pared. ¿Sobre qué tipo de plano está montada la puerta corredera?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Vertical plane', 'es': 'Plano vertical'},
          'hint': {'en': 'This type of plane stands upright, like a wall.', 'es': 'Este tipo de avión se mantiene en posición vertical, como una pared.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq3.jpg',
        },
        {
          'question':
              {'en': 'A skier is descending a snow-covered slope. The slope forms an angle of 30° with the horizontal. What type of plane is the slope of the hill considered to be?', 
              'es': 'Un esquiador desciende por una pendiente nevada. La pendiente forma un ángulo de 30° con la horizontal. ¿Qué tipo de plano se considera la pendiente de la colina?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Inclined plane', 'es': 'Plano inclinado'},
          'hint': {'en': 'Skiers typically go down this slanted type of surface.', 'es': 'Los esquiadores normalmente bajan por este tipo de superficie inclinada.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq4.jpg',
        },
        {
          'question':
              {'en': 'A shelf in your house is mounted on the wall. The surface of the shelf is parallel to the ground. What type of plane is the shelf considered to be?', 
              'es': 'En tu casa hay una estantería montada en la pared. Su superficie es paralela al suelo. ¿Qué tipo de plano se considera la estantería?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Horizontal plane', 'es': 'Plano horizontal'},
          'hint': {'en': 'Think about a level surface where items rest without rolling.', 'es': 'Piense en una superficie nivelada donde los objetos descansen sin rodar.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq5.jpg',
        },
        {
          'question':
              {'en': 'In a science experiment, a student places a book on an inclined surface that forms a 15° angle with the floor. What type of plane does the inclined surface represent?', 
              'es': 'En un experimento científico, un estudiante coloca un libro sobre una superficie inclinada que forma un ángulo de 15° con el suelo. ¿Qué tipo de plano representa la superficie inclinada?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Inclined plane', 'es': 'Plano inclinado'},
          'hint': {'en': 'An angled plane that causes items to slide or roll.', 'es': 'Un plano en ángulo que hace que los objetos se deslicen o rueden.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq6.jpg',
        },
        {
          'question':
              {'en': 'A photographer uses a vertical backdrop for a photo shoot, ensuring it is perfectly upright. What type of plane is the backdrop placed on?', 
              'es': 'Un fotógrafo utiliza un fondo vertical para una sesión de fotos, asegurándose de que esté perfectamente vertical. ¿Sobre qué tipo de plano se coloca el fondo?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Vertical plane', 'es': 'Plano vertical'},
          'hint': {'en': 'This plane goes straight up and down, like a standing wall.', 'es': 'Este avión sube y baja en línea recta, como una pared en posición vertical.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq7.jpg',
        },
        {
          'question':
              {'en': 'A diver jumps from a diving board that extends horizontally over a pool. Which type of plane does the diving board represent?', 
              'es': 'Un saltador salta desde un trampolín que se extiende horizontalmente sobre una piscina. ¿Qué tipo de plano representa el trampolín?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Horizontal plane', 'es': 'Plano horizontal'},
          'hint': {'en': 'A flat, level surface that’s parallel to the water below.', 'es': 'Una superficie plana y nivelada que es paralela al agua que se encuentra debajo.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq8.jpg',
        },
        {
          'question':
              {'en': 'A car is parked on a road that is tilted to help rainwater drain. The slope of the road is at a 5° incline. What type of plane is the surface of the road considered to be?', 
              'es': 'Un coche está aparcado en una carretera inclinada para facilitar el drenaje del agua de lluvia. La pendiente de la carretera es de 5°. ¿Qué tipo de superficie plana se considera la carretera?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Inclined plane', 'es': 'Plano inclinado'},
          'hint': {'en': 'Even a slight slope counts as this kind of angled plane.', 'es': 'Incluso una ligera pendiente se considera este tipo de plano en ángulo.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq9.webp',
        },
        {
          'question':
              {'en': 'In a factory, workers assemble parts on a conveyor belt. The conveyor belt is tilted slightly to move items. What type of plane does the surface of the conveyor belt represent?', 
              'es': 'En una fábrica, los trabajadores ensamblan piezas en una cinta transportadora. Esta se inclina ligeramente para mover los artículos. ¿Qué tipo de plano representa la superficie de la cinta transportadora?'},
          'options': {'en': ['Horizontal plane', 'Vertical plane', 'Inclined plane'], 'es': ['Plano horizontal', 'Plano vertical', 'Plano inclinado']},
          'correctAnswer': {'en': 'Inclined plane', 'es': 'Plano inclinado'},
          'hint': {'en': 'This type of plane helps items move from one height to another.', 'es': 'Este tipo de avión ayuda a mover objetos de una altura a otra.'},
          'questionImage': 'assets/Mathgeometry/plane/quiz/pq10.jpg',
        },
      ],
    },
    'section': [
      {
        'title': 'Learn',
        'icon': Icons.book,
        'color': const Color(0xFF09C4B0),
        'darkcolor': const Color(0xFF147E70),
        'page': 'learn',
      },
      {
        'title': 'Practice',
        'icon': Icons.lightbulb_outline,
        'color': const Color(0xFF09C4B0),
        'darkcolor': const Color(0xFF147E70),
        'page': 'practice',
      },
      {
        'title': 'Quiz',
        'icon': Icons.question_answer_outlined,
        'color': const Color(0xFF09C4B0),
        'darkcolor': const Color(0xFF147E70),
        'page': 'quiz',
      },
    ],
  },
  {
    'name': 'Angles',
    'icon': Icons.call_split,
    'color': const Color(0xFF8B5CF6),
    'darkcolor': const Color(0xFF5E3A70),
    'intro': {
      'definition': {
        'en': 'An angle is a figure formed by two rays sharing a common endpoint called the vertex.',
        'es': 'Un ángulo es una figura formada por dos rayos que comparten un punto final común llamado vértice.'
      },
      'types': [
        {
          'title': {'en': 'Acute Angle', 'es': 'Ángulo Agudo'},
          'description': {
            'en': 'An angle less than 90 degrees.',
            'es': 'Un ángulo menor de 90 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/angles/Acute_E.png',
            'es': 'assets/Mathgeometry/angles/AcuteAngle_s.png'
          }
        },
        {
          'title': {'en': 'Right Angle', 'es': 'Ángulo Recto'},
          'description': {
            'en': 'An angle of exactly 90 degrees.',
            'es': 'Un ángulo de exactamente 90 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/angles/Right_Angle_E.png',
            'es': 'assets/Mathgeometry/angles/RightAngle_S.png'
          }
        },
        {
          'title': {'en': 'Obtuse Angle', 'es': 'Ángulo Obtuso'},
          'description': {
            'en': 'An angle greater than 90 degrees.',
            'es': 'Un ángulo mayor de 90 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/angles/ObtuseANgle_E.png',
            'es': 'assets/Mathgeometry/angles/ObtuseAngle_S.png'
          }
        },
        {
          'title': {'en': 'Straight Angle', 'es': 'Ángulo Rectilíneo'},
          'description': {
            'en': 'An angle of exactly 180 degrees.',
            'es': 'Un ángulo de exactamente 180 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/angles/StraightAngle_E.png',
            'es': 'assets/Mathgeometry/angles/StraightAngle_S.png'
          }
        },
        {
          'title': {'en': 'Reflex Angle', 'es': 'Ángulo Reflejo'},
          'description': {
            'en': 'An angle greater than 180 degrees and less than 360 degrees.',
            'es': 'Un ángulo mayor de 180 grados y menor de 360 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/angles/ReflexAngle_E.png',
            'es': 'assets/Mathgeometry/angles/ReflexAngle_S.png'
          }
        },
        {
          'title': {'en': 'Full Rotation Angle', 'es': 'Ángulo de Rotación Completa'},
          'description': {
            'en': 'An angle of exactly 360 degrees.',
            'es': 'Un ángulo de exactamente 360 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/angles/FullRotationAngle_E.png',
            'es': 'assets/Mathgeometry/angles/FullRotationAngle_s.png'
          }
        },
      ],
      'mainImage': {
        'en': 'assets/Mathgeometry/angles/Angles_E.png',
        'es': 'assets/Mathgeometry/angles/Angles_S.png'
      },
    },
    'practice': {
      'questions': [
        {
          'question': 
          {'en': 'What is the measure of a right angle?', 
          'es': '¿Cuál es la medida de un ángulo recto?'},
          'answers': [
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': true},
            {'text': {'en': '45 degrees', 'es': '45 grados'}, 'correct': false},
            {'text': {'en': '120 degrees', 'es': '120 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is the measure of an acute angle?', 
          'es': '¿Cuál es la medida de un ángulo agudo?'},
          'answers': [
            {'text': {'en': 'Less than 90 degrees', 'es': 'Menos de 90 grados'}, 'correct': true},
            {'text': {'en': 'Exactly 90 degrees', 'es': 'Exactamente 90 grados'}, 'correct': false},
            {'text': {'en': 'More than 90 degrees', 'es': 'Más de 90 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What type of angle is this?', 
          'es': '¿Qué tipo de ángulo es este?'},
          'answers': [
            {'text': {'en': 'Reflex Angle', 'es': 'Ángulo reflejo'}, 'correct': true},
            {'text': {'en': 'Acute Angle', 'es': 'Ángulo agudo'}, 'correct': false},
            {'text': {'en': 'Straight Angle', 'es': 'Ángulo recto'}, 'correct': false},
          ],
          'questionImage': 'assets/Mathgeometry/angles/Reflex_Angle.png',
        },
        {
          'question': 
          {'en': 'What is the measure of an obtuse angle?', 
          'es': '¿Cuál es la medida de un ángulo obtuso?'},
          'answers': [
            {'text': {'en': 'More than 90 degrees', 'es': 'More than 90 degrees'}, 'correct': true},
            {'text': {'en': 'Exactly 90 degrees', 'es': 'Exactly 90 degrees'}, 'correct': false},
            {'text': {'en': 'Less than 90 degrees', 'es': 'Menos de 90 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which of the following lists correctly classifies the angles in order?', 
          'es': '¿Cuál de las siguientes listas clasifica correctamente los ángulos en orden?'},
          'answers': [
            {'text': {'en': 'Acute, Right, Reflex, Obtuse', 'es': 'Agudo, Derecho, Reflejo, Obtuso'}, 'correct': true},
            {'text': {'en': 'Acute, Right, Obtuse, Reflex', 'es': 'Agudo, Derecho, Obtuso, Reflejo'}, 'correct': false},
            {'text': {'en': 'Right, Acute, Obtuse, Reflex', 'es': 'Derecha, Aguda, Obtusa, Refleja'}, 'correct': false},
          ],
          'questionImage': 'assets/Mathgeometry/angles/4.png',
        },
        {
          'question': 
          {'en': 'Identify Obtuse Angle', 
          'es': 'Identificar el ángulo obtuso'},
          'answers': [
            {'text': {'en': 'A', 'es': 'A'}, 'correct': false},
            {'text': {'en': 'B', 'es': 'B'}, 'correct': false},
            {'text': {'en': 'C', 'es': 'C'}, 'correct': true},
          ],
          'questionImage': 'assets/Mathgeometry/angles/3.png',
        },
        {
          'question': 
          {'en': 'Identify Reflex Angle', 
          'es': 'Identificar el ángulo reflejo'},
          'answers': [
            {'text': {'en': 'A', 'es': 'A'}, 'correct': false},
            {'text': {'en': 'B', 'es': 'B'}, 'correct': true},
            {'text': {'en': 'C', 'es': 'C'}, 'correct': false},
          ],
          'questionImage': 'assets/Mathgeometry/angles/3.png',
        },
        {
          'question': 
          {'en': 'Which of the following could be the measure of a reflex angle?', 
          'es': '¿Cuál de las siguientes podría ser la medida de un ángulo reflejo?'},
          'answers': [
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': false},
            {'text': {'en': '45 degrees', 'es': '45 grados'}, 'correct': false},
            {'text': {'en': '220 degrees', 'es': '220 grados'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is the measure of a straight angle?', 
          'es': '¿Cual es la medida de un ángulo recto?'},
          'answers': [
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': false},
            {'text': {'en': '180 degrees', 'es': '180 grados'}, 'correct': true},
            {'text': {'en': '360 degrees', 'es': '360 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is the measure of a full rotation angle?', 
          'es': '¿Cuál es la medida de un ángulo de rotación completo?'},
          'answers': [
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': false},
            {'text': {'en': '45 degrees', 'es': '45 grados'}, 'correct': false},
            {'text': {'en': '360 degrees', 'es': '360 grados'}, 'correct': true},
          ],
          'questionImage': '',
        },
      ],
    },
    'quiz': {
      'questions': [
        {
          'question':
              {'en': 'A ladder is leaning against a wall, forming an angle of 60° with the ground. What type of angle is formed between the ladder and ground?', 
              'es': 'Una escalera está apoyada contra una pared, formando un ángulo de 60° con el suelo. ¿Qué tipo de ángulo se forma entre la escalera y el suelo?'},
          'options': {'en': ['Acute Angle', 'Right Angle', 'Obtuse Angle'], 'es': ['Ángulo agudo', 'Ángulo recto', 'Ángulo obtuso']},
          'correctAnswer': {'en': 'Acute Angle', 'es': 'Ángulo agudo'},
          'hint': {'en': 'The angle is less than 90 degrees.', 'es': 'El ángulo es menor de 90 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq1.jpg',
        },
        {
          'question':
              {'en': 'The hands of a clock show 10:10, forming an angle of approximately 150° between them. What type of angle is this?', 
              'es': 'Las manecillas de un reloj marcan las 10:10 y forman un ángulo de aproximadamente 150°. ¿Qué tipo de ángulo es este?'},
          'options': {'en': ['Right Angle', 'Obtuse Angle', 'Reflex Angle'], 'es': ['Ángulo recto', 'Ángulo obtuso', 'Ángulo reflejo']},
          'correctAnswer': {'en': 'Obtuse Angle', 'es': 'Ángulo obtuso'},
          'hint': {'en': 'Angle formed is greater than 90 degrees but less than 180 degrees.', 'es': 'El ángulo formado es mayor de 90 grados pero menor de 180 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq2.png',
        },
        {
          'question':
              {'en': 'A road sign shows a bend where the road turns sharply, forming a 90 degree angle. What type of angle does this represent?', 
              'es': 'Una señal de tráfico muestra una curva donde la carretera gira bruscamente, formando un ángulo de 90 grados. ¿Qué tipo de ángulo representa esto?'},
          'options': {'en': ['Right Angle', 'Straight Angle', 'Acute Angle'], 'es': ['Ángulo recto', 'Ángulo recto', 'Ángulo agudo']},
          'correctAnswer': {'en': 'Right Angle', 'es': 'Ángulo recto'},
          'hint': {'en': 'Angle formed is exactly 90 degrees.', 'es': 'El ángulo formado es exactamente 90 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq3.jpg',
        },
        {
          'question':
              {'en': 'A seesaw is perfectly horizontal in its resting position. What angle is formed between the two sides?', 
              'es': 'Un balancín está perfectamente horizontal en posición de reposo. ¿Qué ángulo se forma entre sus dos lados?'},
          'options': {'en': ['Straight Angle', 'Right Angle', 'Full Rotation Angle'], 'es': ['Ángulo recto', 'Ángulo recto', 'Ángulo de rotación completa']},
          'correctAnswer': {'en': 'Straight Angle', 'es': 'Ángulo recto'},
          'hint': {'en': 'Angle formed is exactly 180 degrees.', 'es': 'El ángulo formado es exactamente 180 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq4.jpeg',
        },
        {
          'question':
              {'en': 'A ferris wheel completes one full rotation (360°). What type of angle does this represent?', 
              'es': 'Una noria da una vuelta completa (360°). ¿Qué tipo de ángulo representa esto?'},
          'options': {'en': ['Reflex Angle', 'Full Rotation Angle', 'Straight Angle'], 'es': ['Ángulo reflejo', 'Ángulo de rotación completa', 'Ángulo recto']},
          'correctAnswer': {'en': 'Full Rotation Angle', 'es': 'Ángulo de rotación completo'},
          'hint': {'en': 'Angle formed is exactly 360 degrees.', 'es': 'El ángulo formado es exactamente 360 ​​grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq5.webp',
        },
        {
          'question':
              {'en': 'A car ramp is inclined at an angle of 120° with the ground. What type of angle does this represent?', 
              'es': 'Una rampa para vehículos está inclinada 120° con respecto al suelo. ¿Qué tipo de ángulo representa esto?'},
          'options': {'en': ['Obtuse Angle', 'Acute Angle', 'Reflex Angle'], 'es': ['Ángulo obtuso', 'Ángulo agudo', 'Ángulo reflejo']},
          'correctAnswer': {'en': 'Obtuse Angle', 'es': 'Ángulo obtuso'},
          'hint': {'en': 'Angle is greater than 90 degrees but less than 180 degrees.', 'es': 'El ángulo es mayor de 90 grados pero menor de 180 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq6.jpg',
        },
        {
          'question':
              {'en': 'The sails of a windmill form angles as they rotate. If two adjacent sails form an angle of exactly 90°, what type of angle is this?', 
              'es': 'Las aspas de un molino de viento forman ángulos al girar. Si dos aspas adyacentes forman un ángulo de exactamente 90°, ¿qué tipo de ángulo es este?'},
          'options': {'en': ['Acute Angle', 'Right Angle ', 'Straight Angle'], 'es': ['Ángulo agudo', 'Ángulo recto', 'Ángulo llano']},
          'correctAnswer': {'en': 'Right Angle ', 'es': 'Ángulo recto'},
          'hint': {'en': 'Angle formed is exactly 90 degrees.', 'es': 'El ángulo formado es exactamente 90 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq7.jpg',
        },
        {
          'question':
              {'en': 'A pizza slice has a pointed tip forming an angle of approximately 30°. What type of angle is at the tip?', 
              'es': 'Una rebanada de pizza tiene una punta puntiaguda que forma un ángulo de aproximadamente 30°. ¿Qué tipo de ángulo tiene la punta?'},
          'options': {'en': ['Acute Angle', 'Right Angle', 'Obtuse Angle'], 'es': ['Ángulo agudo', 'Ángulo recto', 'Ángulo obtuso']},
          'correctAnswer': {'en': 'Acute Angle', 'es': 'Ángulo agudo'},
          'hint': {'en': 'Angle formed is less than 90 degrees.', 'es': 'El ángulo formado es menor a 90 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq8.jpg',
        },
        {
          'question':
              {'en': 'The pages of an open book form an angle of about 180° when laid flat on a table. What type of angle is formed at the spine of the book?', 
              'es': 'Las páginas de un libro abierto forman un ángulo de aproximadamente 180° al colocarse sobre una mesa. ¿Qué tipo de ángulo se forma en el lomo del libro?'},
          'options': {'en': ['Straight Angle', 'Reflex Angle', 'Right Angle'], 'es': ['Ángulo recto', 'Ángulo reflejo', 'Ángulo recto']},
          'correctAnswer': {'en': 'Straight Angle', 'es': 'Ángulo recto'},
          'hint': {'en': 'Angle formed is exactly 180 degrees.', 'es': 'El ángulo formado es exactamente 180 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq9.jpg',
        },
        {
          'question':
              {'en': 'A slice of a circular pie has an angle of 45° at its tip. What type of angle is represented at the tip of the slice?', 
              'es': 'Una rebanada de pastel circular tiene un ángulo de 45° en la punta. ¿Qué tipo de ángulo representa la punta de la rebanada?'},
          'options': {'en': ['Acute Angle', 'Obtuse Angle', 'Right Angle'], 'es': ['Ángulo agudo', 'Ángulo obtuso', 'Ángulo recto']},
          'correctAnswer': {'en': 'Acute Angle', 'es': 'Ángulo agudo'},
          'hint': {'en': 'Angle formed is less than 90 degrees.', 'es': 'El ángulo formado es menor a 90 grados.'},
          'questionImage': 'assets/Mathgeometry/angles/quiz/aq10.webp',
        },
      ],
    },
    'section': [
      {
        'title': 'Learn',
        'icon': Icons.book,
        'color': const Color(0xFF8B5CF6),
        'darkcolor': const Color(0xFF5E3A70),
        'page': 'learn',
      },
      {
        'title': 'Practice',
        'icon': Icons.lightbulb_outline,
        'color': const Color(0xFF8B5CF6),
        'darkcolor': const Color(0xFF5E3A70),
        'page': 'practice',
      },
      {
        'title': 'Quiz',
        'icon': Icons.question_answer_outlined,
        'color': const Color(0xFF8B5CF6),
        'darkcolor': const Color(0xFF5E3A70),
        'page': 'quiz',
      },
    ],
  },
  {
    'name': 'Triangle',
    'icon': Icons.change_history,
    'color': const Color(0xFFFF5963),
    'darkcolor': const Color(0xFFC62828),
    'intro': {
      'definition': {
        'en': 'A triangle is a polygon with three edges and three vertices.',
        'es': 'Un triángulo es un polígono con tres lados y tres vértices.'
      },
      'types': [
        {
          'title': {'en': 'Equilateral Triangle', 'es': 'Triángulo Equilátero'},
          'description': {
            'en': 'A triangle with all three sides of equal length.',
            'es': 'Un triángulo con todos los lados de igual longitud.'
          },
          'image': {
            'en': 'assets/Mathgeometry/triangle/Equilateral_E.png',
            'es': 'assets/Mathgeometry/triangle/Equilateral_S.png'
          }
        },
        {
          'title': {'en': 'Isosceles Triangle', 'es': 'Triángulo Isósceles'},
          'description': {
            'en': 'A triangle with at least two sides of equal length.',
            'es': 'Un triángulo con al menos dos lados de igual longitud.'
          },
          'image': {
            'en': 'assets/Mathgeometry/triangle/Isoceles_E.png',
            'es': 'assets/Mathgeometry/triangle/Isoceles_S.png'
          }
        },
        {
          'title': {'en': 'Scalene Triangle', 'es': 'Triángulo Escaleno'},
          'description': {
            'en': 'A triangle with all sides of different lengths.',
            'es': 'Un triángulo con todos los lados de longitudes diferentes.'
          },
          'image': {
            'en': 'assets/Mathgeometry/triangle/Scalene_E.png',
            'es': 'assets/Mathgeometry/triangle/Scalene_S.png'
          }
        },
        {
          'title': {'en': 'Acute Triangle', 'es': 'Triángulo Acutángulo'},
          'description': {
            'en': 'A triangle in which all angles are acute (less than 90 degrees).',
            'es': 'Un triángulo en el que todos los ángulos son agudos (menores de 90 grados).'
          },
          'image': {
            'en': 'assets/Mathgeometry/triangle/Acute_E.png',
            'es': 'assets/Mathgeometry/triangle/Acute_S.png'
          }
        },
        {
          'title': {'en': 'Obtuse Triangle', 'es': 'Triángulo Obtusángulo'},
          'description': {
            'en': 'A triangle in which one angle is obtuse (greater than 90 degrees).',
            'es': 'Un triángulo en el que un ángulo es obtuso (mayor de 90 grados).'
          },
          'image': {
            'en': 'assets/Mathgeometry/triangle/Obtuse_E.png',
            'es': 'assets/Mathgeometry/triangle/Obtuse_S.png'
          }
        },
        {
          'title': {'en': 'Right Triangle', 'es': 'Triángulo Rectángulo'},
          'description': {
            'en': 'A triangle in which one angle is a right angle (90 degrees).',
            'es': 'Un triángulo en el que un ángulo es recto (90 grados).'
          },
          'image': {
            'en': 'assets/Mathgeometry/triangle/Right_E.png',
            'es': 'assets/Mathgeometry/triangle/Right_S.png'
          }
        },
      ],
      'mainImage': {
        'en': 'assets/Mathgeometry/triangle/Triangle_E.png',
        'es': 'assets/Mathgeometry/triangle/Triangle_S.png'
      },
    },
    'practice': {
      'questions': [
        {
          'question': 
          {'en': 'What is the sum of angles in a triangle?', 
          'es': '¿Cuál es la suma de los ángulos de un triángulo?'},
          'answers': [
            {'text': {'en': '180 degrees', 'es': '180 grados'}, 'correct': true},
            {'text': {'en': '90 degrees', 'es': '90 grados'}, 'correct': false},
            {'text': {'en': '360 degrees', 'es': '360 grados'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a triangle with all sides of equal length called?', 
          'es': '¿Cómo se llama un triángulo que tiene todos los lados de igual longitud?'},
          'answers': [
            {'text': {'en': 'Equilateral triangle', 'es': 'Triángulo equilátero'}, 'correct': true},
            {'text': {'en': 'Isosceles triangle', 'es': 'Triángulo isósceles'}, 'correct': false},
            {'text': {'en': 'Scalene triangle', 'es': 'Triángulo escaleno'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What defines a right-angled triangle?', 
          'es': '¿Qué define a un triángulo rectángulo?'},
          'answers': [
            {'text': {'en': 'A triangle with one angle less than 90°', 'es': 'A triangle with one angle less than 90°'}, 'correct': false},
            {'text': {'en': 'A triangle with one angle equal to 90°', 'es': 'A triangle with one angle equal to 90°'}, 'correct': true},
            {'text': {'en': 'A triangle with all sides equal', 'es': 'Un triángulo con todos los lados iguales'}, 'correct': false}, 
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which type of triangle has all angles less than 90°?', 
          'es': '¿Qué tipo de triángulo tiene todos los ángulos menores a 90°?'},
          'answers': [
            {'text': {'en': 'Right triangle', 'es': 'Triángulo rectángulo'}, 'correct': false},
            {'text': {'en': 'Obtuse triangle', 'es': 'Triángulo obtuso'}, 'correct': false}, 
            {'text': {'en': 'Acute triangle', 'es': 'Triángulo agudo'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'How many equal sides does an isosceles triangle have?', 
          'es': '¿Cuántos lados iguales tiene un triángulo isósceles?'},
          'answers': [
            {'text': {'en': 'None', 'es': 'Ninguna'}, 'correct': false},
            {'text': {'en': 'Three', 'es': 'Tres'}, 'correct': false},
            {'text': {'en': 'Two', 'es': 'Dos'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which triangle has no equal sides?', 
          'es': '¿Qué triángulo no tiene lados iguales?'},
          'answers': [
            {'text': {'en': 'Scalene triangle', 'es': 'Triángulo escaleno'}, 'correct': true},
            {'text': {'en': 'Isosceles triangle', 'es': 'Triángulo isósceles'}, 'correct': false},
            {'text': {'en': 'Equilateral triangle', 'es': 'Triángulo equilátero'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'True or False: In an equilateral triangle, all angles are 60°.', 
          'es': 'Verdadero o falso: En un triángulo equilátero, todos los ángulos miden 60°.'},
          'answers': [
            {'text': {'en': 'True', 'es': 'Verdadero'}, 'correct': true},
            {'text': {'en': 'False', 'es': 'Falso'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Identify the type of triangle formed by sides of 3 cm, 4 cm, and 5 cm.', 
          'es': 'Identifica el tipo de triángulo formado por lados de 3 cm, 4 cm y 5 cm.'},
          'answers': [
            {'text': {'en': 'Scalene triangle', 'es': 'Triángulo escaleno'}, 'correct': true},
            {'text': {'en': 'Isosceles triangle', 'es': 'Triángulo isósceles'}, 'correct': false},
            {'text': {'en': 'Acute triangle', 'es': 'Triángulo agudo'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a triangle with one angle greater than 90 degrees called?', 
          'es': '¿Cómo se llama un triángulo con un ángulo mayor a 90 grados?'},
          'answers': [
            {'text': {'en': 'Acute triangle', 'es': 'Triángulo agudo'}, 'correct': false},
            {'text': {'en': 'Obtuse triangle', 'es': 'Triángulo obtuso'}, 'correct': true},
            {'text': {'en': 'Right triangle', 'es': 'Triángulo rectángulo'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which triangle has two equal angles and two equal sides?', 
          'es': '¿Qué triángulo tiene dos ángulos iguales y dos lados iguales?'},
          'answers': [
            {'text': {'en': 'Isosceles triangle', 'es': 'Triángulo isósceles'}, 'correct': true},
            {'text': {'en': 'Right triangle', 'es': 'Triángulo rectángulo'}, 'correct': false},
            {'text': {'en': 'Scalene triangle', 'es': 'Triángulo escaleno'}, 'correct': false},
          ],
          'questionImage': '',
        },
      ],
    },
    'quiz': {
      'questions': [
        {
          'question':
              {'en': 'You see a road sign shaped like a triangle. It has all sides of equal length. What type of triangle is the sign?',
              'es': 'Ves una señal de tráfico con forma de triángulo. Tiene todos los lados iguales. ¿Qué tipo de triángulo es la señal?'},
          'options': {'en': ['Equilateral', 'Isosceles', 'Scalene'], 'es': ['Equilátero', 'Isósceles', 'Escaleno']},
          'correctAnswer': {'en': 'Equilateral', 'es': 'Equilátero'},
          'hint': {'en': 'All three sides are of equal length.', 'es': 'Los tres lados tienen la misma longitud.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/tq1.webp',
        },
        {
          'question':
              {'en': 'The roof of a house has a triangular structure. The two sloping sides are equal in length, and the base is shorter. What type of triangle is the roof?',
              'es': 'El techo de una casa tiene una estructura triangular. Los dos lados inclinados tienen la misma longitud y la base es más corta. ¿Qué tipo de triángulo es el techo?'},
          'options': {'en': ['Equilateral', 'Isosceles', 'Scalene'], 'es': ['Equilátero', 'Isósceles', 'Escaleno']},
          'correctAnswer': {'en': 'Isosceles', 'es': 'Isósceles'},
          'hint': {'en': 'Two sides are of equal length.', 'es': 'Dos lados tienen la misma longitud.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/tq2.webp',
        },
        {
          'question':
              {'en': 'A slice of watermelon is cut into a triangular shape where all three sides are of same lengths. What type of triangle is it?',
              'es': 'Una rebanada de sandía se corta en forma triangular, con los tres lados de la misma longitud. ¿Qué tipo de triángulo es?'},
          'options': {'en': ['Equilateral', 'Isosceles', 'Scalene'], 'es': ['Equilátero', 'Isósceles', 'Escaleno']},
          'correctAnswer': {'en': 'Equilateral', 'es': 'Equilátero'},
          'hint': {'en': 'All three sides are of equal length.', 'es': 'Los tres lados tienen la misma longitud.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/tq3.jpg',
        },
        {
          'question':
              {'en': 'A handkerchief is folded into a triangular shape where all the angles are smaller than 90 degrees. What type of triangle does it represent?',
              'es': 'Un pañuelo está doblado en forma triangular, donde todos los ángulos son menores de 90 grados. ¿Qué tipo de triángulo representa?'},
          'options': {'en': ['Obtuse-angled', 'Right-angled', 'Acute-angled'], 'es': ['De ángulo obtuso', 'De ángulo recto', 'De ángulo agudo']},
          'correctAnswer': {'en': 'Acute-angled', 'es': 'De ángulo agudo'},
          'hint': {'en': 'All three angles are less than 90 degrees.', 'es': 'Los tres ángulos son menores a 90 grados.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/tq4.jpg',
        },
        {
          'question':
              {'en': 'A ladder placed against a wall forms a triangle with the ground. The angle between the ladder and the ground is 90 degrees. What type of triangle is formed?',
              'es': 'Una escalera apoyada contra una pared forma un triángulo con el suelo. El ángulo entre la escalera y el suelo es de 90 grados. ¿Qué tipo de triángulo se forma?'},
          'options': {'en': ['Acute-angled', 'Right-angled', 'Obtuse-angled'], 'es': ['Agudo', 'Rectángulo', 'Obtuso']},
          'correctAnswer': {'en': 'Right-angled', 'es': 'En ángulo recto'},
          'hint': {'en': 'One angle is exactly 90 degrees.', 'es': 'Un ángulo mide exactamente 90 grados.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/q5.png',
        },
        {
          'question':
              {'en': 'A wooden stand is shaped like a triangle, and one of its angles is more than 90 degrees. What kind of triangle is it?',
              'es': 'Un soporte de madera tiene forma de triángulo y uno de sus ángulos mide más de 90 grados. ¿Qué tipo de triángulo es?'},
          'options': {'en': ['Right-angled', 'Scalene', 'Obtuse-angled'], 'es': ['De ángulo recto', 'Escaleno', 'De ángulo obtuso']},
          'correctAnswer': {'en': 'Obtuse-angled', 'es': 'De ángulo obtuso'},
          'hint': {'en': 'One angle is greater than 90 degrees.', 'es': 'Un ángulo es mayor de 90 grados.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/q7.png',
        },
        {
          'question':
              {'en': 'You cut a piece of cardboard into a triangle with all sides of different lengths. What type of triangle is it?',
              'es': 'Cortas un trozo de cartón en un triángulo con lados de diferente longitud. ¿Qué tipo de triángulo es?'},
          'options': {'en': ['Equilateral', 'Scalene', 'Isosceles'], 'es': ['Equilátero', 'Escaleno', 'Isósceles']},
          'correctAnswer': {'en': 'Scalene', 'es': 'Escaleno'},
          'hint': {'en': 'All sides have different lengths.', 'es': 'Todos los lados tienen longitudes diferentes.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/q7.png',
        },
        {
          'question':
              {'en': 'A flag is made in a triangle shape where two angles are equal and one is different. What triangle does it represent?',
              'es': 'Una bandera tiene forma de triángulo, con dos ángulos iguales y uno distinto. ¿Qué triángulo representa?'},
          'options': {'en': ['Isosceles', 'Scalene', 'Equilateral'], 'es': ['Isósceles', 'Escaleno', 'Equilátero']},
          'correctAnswer': {'en': 'Isosceles', 'es': 'Isósceles'},
          'hint': {'en': 'Two angles (and sides) are the same.', 'es': 'Dos ángulos (y lados) son iguales.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/q8.png',
        },
        {
          'question':
              {'en': 'A bridge has triangular trusses with all angles measuring 60°. What type of triangle are the trusses shaped in?',
              'es': 'Un puente tiene cerchas triangulares cuyos ángulos miden 60°. ¿Qué tipo de triángulo tienen las cerchas?'},
          'options': {'en': ['Isosceles', 'Equilateral', 'Acute-angled'], 'es': ['Isósceles', 'Equilátero', 'Agudo-angulado']},
          'correctAnswer': {'en': 'Equilateral', 'es': 'Equilátero'},
          'hint': {'en': 'Each angle is 60°, and all sides are equal.', 'es': 'Cada ángulo mide 60° y todos los lados son iguales.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/q9.png',
        },
        {
          'question':
              {'en': 'A pizza slice forms a triangle with two equal sides and a sharp tip. What kind of triangle is it likely to be?',
              'es': 'Una rebanada de pizza forma un triángulo con dos lados iguales y una punta afilada. ¿Qué tipo de triángulo es probable que sea?'},
          'options': {'en': ['Scalene', 'Equilateral', 'Isosceles'], 'es': ['Escaleno', 'Equilátero', 'Isósceles']},
          'correctAnswer': {'en': 'Isosceles', 'es': 'Isósceles'},
          'hint': {'en': 'Two equal edges from the crust to the tip.', 'es': 'Dos bordes iguales desde la corteza hasta la punta.'},
          'questionImage': 'assets/Mathgeometry/triangle/quiz/q10.png',
        },
      ],
    },
    'section': [
      {
        'title': 'Learn',
        'icon': Icons.book,
        'color': const Color(0xFFFF5963),
        'darkcolor': const Color(0xFFC62828),
        'page': 'learn',
      },
      {
        'title': 'Practice',
        'icon': Icons.lightbulb_outline,
        'color': const Color(0xFFFF5963),
        'darkcolor': const Color(0xFFC62828),
        'page': 'practice',
      },
      {
        'title': 'Quiz',
        'icon': Icons.question_answer_outlined,
        'color': const Color(0xFFFF5963),
        'darkcolor': const Color(0xFFC62828),
        'page': 'quiz',
      },
    ],
  },
  {
    'name': 'Quadrilateral',
    'icon': Icons.crop_square,
    'color': const Color(0xFF5CB85C),
    'darkcolor': const Color(0xFF388E3C),
    'intro': {
      'definition': {
        'en': 'A quadrilateral is a polygon with four sides and four vertices.',
        'es': 'Un cuadrilátero es un polígono con cuatro lados y cuatro vértices.'
      },
      'types': [
        {
          'title': {'en': 'Square', 'es': 'Cuadrado'},
          'description': {
            'en': 'A quadrilateral with all four sides of equal length and all angles equal to 90 degrees.',
            'es': 'Un cuadrilátero con los cuatro lados de igual longitud y todos los ángulos de 90 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/quadrilateral/Square_E.png',
            'es': 'assets/Mathgeometry/quadrilateral/Square_S.png'
          }
        },
        {
          'title': {'en': 'Rectangle', 'es': 'Rectángulo'},
          'description': {
            'en': 'A quadrilateral with opposite sides equal in length and all angles equal to 90 degrees.',
            'es': 'Un cuadrilátero con lados opuestos de igual longitud y todos los ángulos de 90 grados.'
          },
          'image': {
            'en': 'assets/Mathgeometry/quadrilateral/Rectangle_E.png',
            'es': 'assets/Mathgeometry/quadrilateral/Rectangle_S.png'
          }
        },
        {
          'title': {'en': 'Rhombus', 'es': 'Rombus'},
          'description': {
            'en': 'A quadrilateral with all four sides of equal length and opposite angles equal.',
            'es': 'Un cuadrilátero con los cuatro lados de igual longitud y ángulos opuestos iguales.'
          },
          'image': {
            'en': 'assets/Mathgeometry/quadrilateral/Rhombus_E.png',
            'es': 'assets/Mathgeometry/quadrilateral/Rhombus_S.png'
          }
        },
        {
          'title': {'en': 'Trapezoid', 'es': 'Trapecio'},
          'description': {
            'en': 'A quadrilateral with at least one pair of parallel sides.',
            'es': 'Un cuadrilátero con al menos un par de lados paralelos.'
          },
          'image': {
            'en': 'assets/Mathgeometry/quadrilateral/Trapezoid_E.png',
            'es': 'assets/Mathgeometry/quadrilateral/Trapezoid_S.png'
          }
        },
        {
          'title': {'en': 'Parallelogram', 'es': 'Paralelogramo'},
          'description': {
            'en': 'A quadrilateral with opposite sides parallel and equal in length.',
            'es': 'Un cuadrilátero con lados opuestos paralelos y de igual longitud.'
          },
          'image': {
            'en': 'assets/Mathgeometry/quadrilateral/Parallelogram_E.png',
            'es': 'assets/Mathgeometry/quadrilateral/Parallelogram_S.png'
          }
        },
        {
          'title': {'en': 'Kite', 'es': 'Cometa'},
          'description': {
            'en': 'A quadrilateral with two distinct pairs of adjacent sides that are equal in length.',
            'es': 'Un cuadrilátero con dos pares distintos de lados adyacentes de igual longitud.'
          },
          'image': {
            'en': 'assets/Mathgeometry/quadrilateral/Kite_E.png',
            'es': 'assets/Mathgeometry/quadrilateral/Kite_S.png'
          }
        },
      ],
      'mainImage': {
        'en': 'assets/Mathgeometry/quadrilateral/Quadrilateral_E.png',
        'es': 'assets/Mathgeometry/quadrilateral/Quadrilateral_S.png'
      },
    },
    'practice': {
      'questions': [
        {
          'question': 
          {'en': 'Define a square',
          'es': 'Definir un cuadrado'},
          'answers': [
            {'text': {'en': 'A quadrilateral with two right angles', 'es': 'Un cuadrilátero con dos ángulos rectos'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with all sides of equal length', 'es': 'Un cuadrilátero con todos los lados de igual longitud'}, 'correct': true},
            {'text': {'en': 'A quadrilateral with no right angles', 'es': 'Un cuadrilátero sin ángulos rectos'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Define a rectangle',
          'es': 'Definir un rectángulo'},
          'answers': [
            {'text': {'en': 'A quadrilateral with four right angles', 'es': 'Un cuadrilátero con cuatro ángulos rectos'}, 'correct': true},
            {'text': {'en': 'A quadrilateral with all sides of equal length', 'es': 'Un cuadrilátero con todos los lados de igual longitud'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with no right angles', 'es': 'Un cuadrilátero sin ángulos rectos'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Define a parallelogram',
          'es': 'Definir un paralelogramo'},
          'answers': [
            {'text': {'en': 'A quadrilateral with four right angles', 'es': 'Un cuadrilátero con cuatro ángulos rectos'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with all sides of equal length', 'es': 'Un cuadrilátero con todos los lados de igual longitud'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with opposite sides parallel', 'es': 'Un cuadrilátero con lados opuestos paralelos'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Define a Kite',
          'es': 'Definir una cometa'},
          'answers': [
            {'text': {'en': 'A quadrilateral with two distinct pairs of adjacent sides that are equal in length.', 'es': 'Un cuadrilátero con dos pares distintos de lados adyacentes que tienen la misma longitud.'}, 'correct': true},
            {'text': {'en': 'A quadrilateral with all sides equal and opposite angles equal.', 'es': 'Un cuadrilátero con todos los lados iguales y ángulos opuestos iguales.'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with only one pair of parallel sides.', 'es': 'Un cuadrilátero con sólo un par de lados paralelos.'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Define a Rhombus',
          'es': 'Definir un rombo'},
          'answers': [
            {'text': {'en': 'A quadrilateral with all sides of equal length', 'es': 'Un cuadrilátero con todos los lados de igual longitud'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with all four sides of equal length and opposite angles equal.', 'es': 'Un cuadrilátero con los cuatro lados de igual longitud y ángulos opuestos iguales.'}, 'correct': true},
            {'text': {'en': 'A quadrilateral with four right angles', 'es': 'Un cuadrilátero con cuatro ángulos rectos'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Define a Trapezoid',
          'es': 'Definir un trapezoide'},
          'answers': [
            {'text': {'en': 'A quadrilateral with one pair of parallel sides.', 'es': 'Un cuadrilátero con un par de lados paralelos.'}, 'correct': true},
            {'text': {'en': 'A quadrilateral with two pairs of opposite sides equal and all angles 90°.', 'es': 'Un cuadrilátero con dos pares de lados opuestos iguales y todos los ángulos de 90°.'}, 'correct': false},
            {'text': {'en': 'A quadrilateral with four right angles', 'es': 'Un cuadrilátero con cuatro ángulos rectos'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which of the following quadrilaterals has only one pair of parallel sides?',
          'es': '¿Cuál de los siguientes cuadriláteros tiene solo un par de lados paralelos?'},
          'answers': [
            {'text': {'en': 'Rectangle', 'es': 'Rectángulo'}, 'correct': false},
            {'text': {'en': 'Trapezoid', 'es': 'Trapecio'}, 'correct': true},
            {'text': {'en': 'Kite', 'es': 'Cometa'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a kite’s defining property?',
          'es': '¿Cuál es la propiedad que define a una cometa?'},
          'answers': [
            {'text': {'en': 'Two pairs of adjacent sides are equal', 'es': 'Dos pares de lados adyacentes son iguales'}, 'correct': true},
            {'text': {'en': 'All sides are equal', 'es': 'Todos los lados son iguales'}, 'correct': false},
            {'text': {'en': 'It has no right angles', 'es': 'No tiene ángulos rectos'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'True or False: A rhombus is a parallelogram with all sides equal.',
          'es': 'Verdadero o falso: Un rombo es un paralelogramo con todos los lados iguales.'},
          'answers': [
            {'text': {'en': 'True', 'es': 'Verdadero'}, 'correct': true},
            {'text': {'en': 'False', 'es': 'Falso'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'How many sides does a quadrilateral have?',
          'es': '¿Cuántos lados tiene un cuadrilátero?'},
          'answers': [
            {'text': {'en': '3', 'es': '3'}, 'correct': false},
            {'text': {'en': '5', 'es': '5'}, 'correct': false},
            {'text': {'en': '4', 'es': '4'}, 'correct': true},
          ],
          'questionImage': '',
        },
      ],
    },
    'quiz': {
      'questions': [
        {
          'question':
              {'en': 'Which of these is commonly used for a standard window pane, where all four sides are equal and every angle forms a perfect right angle?',
              'es': '¿Cuál de estos se usa comúnmente para un panel de ventana estándar, donde los cuatro lados son iguales y cada ángulo forma un ángulo recto perfecto?'},
          'options': {'en': ['Square', 'Rhombus', 'Trapezoid'], 'es': ['Cuadrado', 'Rombo', 'Trapecio']},
          'correctAnswer': {'en': 'Square', 'es': 'Cuadrado'},
          'hint': {'en': 'All sides are of equal length and all angles are 90 degrees.', 'es': 'Todos los lados tienen la misma longitud y todos los ángulos miden 90 grados.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq1.jpg',
        },
        {
          'question':
              {'en': 'You are designing a table, and you want it to have opposite sides parallel and unequal in length, but with no right angles. What shape would best describe the tabletop?',
              'es': 'Estás diseñando una mesa y quieres que tenga lados opuestos paralelos y de longitud desigual, pero sin ángulos rectos. ¿Qué forma describiría mejor el tablero?'},
          'options': {'en': ['Parallelogram', 'Rectangle', 'Trapezoid'], 'es': ['Paralelogramo', 'Rectángulo', 'Trapecio']},
          'correctAnswer': {'en': 'Trapezoid', 'es': 'Trapecio'},
          'hint': {'en': 'Two sides are parallel and opposite sides are of equal length.', 'es': 'Dos lados son paralelos y los lados opuestos tienen la misma longitud.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq2.jpg',
        },
        {
          'question':
              {'en': 'The wings of a traditional kite often form a shape where two pairs of adjacent sides are equal. What shape does the kite resemble?',
              'es': 'Las alas de una cometa tradicional suelen tener dos pares de lados adyacentes iguales. ¿A qué forma se asemeja la cometa?'},
          'options': {'en': ['Parallelogram', 'Kite', 'Trapezoid'], 'es': ['Paralelogramo', 'Cometa', 'Trapecio']},
          'correctAnswer': {'en': 'Kite', 'es': 'Cometa'},
          'hint': {'en': 'Length of two adjacent sides is the same.', 'es': 'La longitud de dos lados adyacentes es la misma.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq3.jpg',
        },
        {
          'question':
              {'en': 'Which quadrilateral would be most appropriate for the screen of a modern TV or smartphone, where opposite sides are equal and each angle forms a right angle?',
              'es': '¿Qué cuadrilátero sería el más apropiado para la pantalla de un televisor o teléfono inteligente moderno, donde los lados opuestos son iguales y cada ángulo forma un ángulo recto?'},
          'options': {'en': ['Parallelogram', 'Rectangle', 'Trapezoid'], 'es': ['Paralelogramo', 'Rectángulo', 'Trapecio']},
          'correctAnswer': {'en': 'Rectangle', 'es': 'Rectángulo'},
          'hint': {'en': 'Opposite sides are of equal lengths and all angles are 90 degrees.', 'es': 'Los lados opuestos tienen la misma longitud y todos los ángulos miden 90 grados.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq4.webp',
        },
        {
          'question':
              {'en': 'In designing a fancy picture frame, you want all four sides to be of equal length and each angle to be a right angle. What shape best describes this frame?',
              'es': 'Al diseñar un marco elegante, se busca que los cuatro lados tengan la misma longitud y que cada ángulo sea recto. ¿Qué forma describe mejor este marco?'},
          'options': {'en': ['Square', 'Rectangle', 'Kite'], 'es': ['Cuadrado', 'Rectángulo', 'Cometa']},
          'correctAnswer': {'en': 'Square', 'es': 'Cuadrado'},
          'hint': {'en': 'All sides are of equal length and all angles are 90 degrees.', 'es': 'Todos los lados tienen la misma longitud y todos los ángulos miden 90 grados.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq5.jpg',
        },
        {
          'question':
              {'en': 'A book cover has a simple and practical design where opposite sides are parallel and equal, and all angles are right angles. What quadrilateral shape describes the book cover?',
              'es': 'La portada de un libro tiene un diseño sencillo y práctico, donde los lados opuestos son paralelos e iguales, y todos los ángulos son rectos. ¿Qué figura cuadrilátera describe la portada?'},
          'options': {'en': ['Kite', 'Rectangle', 'Rhombus'], 'es': ['Cometa', 'Rectángulo', 'Rombo']},
          'correctAnswer': {'en': 'Rectangle', 'es': 'Rectángulo'},
          'hint': {'en': 'Design with opposite sides parallel and equal, and all angles are right angles.', 'es': 'Diseño con lados opuestos paralelos e iguales, y todos los ángulos son rectos.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq6.jpg',
        },
        {
          'question':
              {'en': 'A diamond-shaped wall clock has all sides of equal length, but the angles are not 90 degrees. What shape does it represent?',
              'es': 'Un reloj de pared con forma de diamante tiene todos los lados de igual longitud, pero los ángulos no miden 90 grados. ¿Qué figura representa?'},
          'options': {'en': ['Rectangle', 'Rhombus', 'Square'], 'es': ['Rectángulo', 'Rombo', 'Cuadrado']},
          'correctAnswer': {'en': 'Rhombus', 'es': 'Rombo'},
          'hint': {'en': 'All sides are equal, but no right angles.', 'es': 'Todos los lados son iguales, pero ningún ángulo recto.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq7.png',
        },
        {
          'question':
              {'en': 'A trapeze artist’s safety net is stretched in a shape where only one pair of sides is parallel. What quadrilateral does this represent?',
              'es': 'La red de seguridad de un trapecista está estirada de forma que solo un par de lados son paralelos. ¿Qué cuadrilátero representa esto?'},
          'options': {'en': ['Kite', 'Trapezoid', 'Rhombus'], 'es': ['Cometa', 'Trapecio', 'Rombo']},
          'correctAnswer': {'en': 'Trapezoid', 'es': 'Trapecio'},
          'hint': {'en': 'Only one pair of opposite sides are parallel.', 'es': 'Sólo un par de lados opuestos son paralelos.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq8.png',
        },
        {
          'question':
              {'en': 'A drawing board is designed with two pairs of equal-length adjacent sides, but the opposite sides are not equal or parallel. What shape is it?',
              'es': 'Un tablero de dibujo está diseñado con dos pares de lados adyacentes de igual longitud, pero los lados opuestos no son iguales ni paralelos. ¿Qué forma tiene?'},
          'options': {'en': ['Kite', 'Parallelogram', 'Rectangle'], 'es': ['Cometa', 'Paralelogramo', 'Rectángulo']},
          'correctAnswer': {'en': 'Kite', 'es': 'Cometa'},
          'hint': {'en': 'Two adjacent sides are of equal length.', 'es': 'Dos lados adyacentes tienen la misma longitud.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq9.png',
        },
        {
          'question':
              {'en': 'You are tiling a floor with a pattern made of slanted quadrilaterals where opposite sides are equal and parallel, but angles are not 90 degrees. What shape are the tiles?',
              'es': 'Estás recubriendo un suelo con un patrón de cuadriláteros inclinados, donde los lados opuestos son iguales y paralelos, pero los ángulos no miden 90 grados. ¿Qué forma tienen las baldosas?'},
          'options': {'en': ['Rhombus', 'Rectangle', 'Kite'], 'es': ['Rombo', 'Rectángulo', 'Cometa']},
          'correctAnswer': {'en': 'Rhombus', 'es': 'Rombo'},
          'hint': {'en': 'Opposite sides are equal and angles are slanted.', 'es': 'Los lados opuestos son iguales y los ángulos están inclinados.'},
          'questionImage': 'assets/Mathgeometry/quadrilateral/quiz/qq10.png',
        },
      ],
    },
    'section': [
      {
        'title': 'Learn',
        'icon': Icons.book,
        'color': const Color(0xFF5CB85C),
        'darkcolor': const Color(0xFF388E3C),
        'page': 'learn',
      },
      {
        'title': 'Practice',
        'icon': Icons.lightbulb_outline,
        'color': const Color(0xFF5CB85C),
        'darkcolor': const Color(0xFF388E3C),
        'page': 'practice',
      },
      {
        'title': 'Quiz',
        'icon': Icons.question_answer_outlined,
        'color': const Color(0xFF5CB85C),
        'darkcolor': const Color(0xFF388E3C),
        'page': 'quiz',
      },
    ],
  },
  {
    'name': 'Circle',
    'icon': Icons.circle,
    'color': const Color(0xFFFFB400),
    'darkcolor': const Color(0xFFB28704),
    'intro': {
      'definition': {
        'en': 'A circle is a closed shape where all points on the boundary are equidistant from the center.',
        'es': 'Un círculo es una forma cerrada donde todos los puntos del límite están a la misma distancia del centro.'
      },
      'types': [
        {
          'title': {'en': 'Radius', 'es': 'Radio'},
          'description': {
            'en': 'The distance from the center of the circle to any point on the circle.',
            'es': 'La distancia desde el centro del círculo a cualquier punto del círculo.'
          },
          'image': {
            'en': 'assets/Mathgeometry/circle/Raduis_E.png',
            'es': 'assets/Mathgeometry/circle/Raduis_S.png'
          }
        },
        {
          'title': {'en': 'Diameter', 'es': 'Diámetro'},
          'description': {
            'en': 'A line segment that passes through the center and has endpoints on the circle (twice the radius).',
            'es': 'Un segmento de línea que pasa por el centro y tiene puntos finales en el círculo (el doble del radio).'
          },
          'image': {
            'en': 'assets/Mathgeometry/circle/Diameter_E.png',
            'es': 'assets/Mathgeometry/circle/Diameter_S.png'
          }
        },
        {
          'title': {'en': 'Circumference', 'es': 'Circunferencia'},
          'description': {
            'en': 'The total distance around the circle.',
            'es': 'La distancia total alrededor del círculo.'
          },
          'image': {
            'en': 'assets/Mathgeometry/circle/Circumference_E.png',
            'es': 'assets/Mathgeometry/circle/Circumference_S.png'
          }
        },
        {
          'title': {'en': 'Chord', 'es': 'Acorde'},
          'description': {
            'en': 'A part of the circumference between two points on the circle.',
            'es': 'Una parte de la circunferencia entre dos puntos del círculo.'
          },
          'image': {
            'en': 'assets/Mathgeometry/circle/Chord_E.png',
            'es': 'assets/Mathgeometry/circle/Chord_S.png'
          }
        },
        {
          'title': {'en': 'Arc', 'es': 'Arco'},
          'description': {
            'en': 'A line segment connecting two points on the circle.',
            'es': 'Un segmento de línea que conecta dos puntos en el círculo.'
          },
          'image': {
            'en': 'assets/Mathgeometry/circle/Arc_E.png',
            'es': 'assets/Mathgeometry/circle/Arc_S.png'
          }
        },
        {
          'title': {'en': 'Tangent', 'es': 'Tangente'},
          'description': {
            'en': 'A straight line that touches the circle at one point without crossing it.',
            'es': 'Una línea recta que toca el círculo en un punto sin cruzarlo.'
          },
          'image': {
            'en': 'assets/Mathgeometry/circle/Tangent_E.png',
            'es': 'assets/Mathgeometry/circle/Tangent_S.png'
          }
        },
      ],
      'mainImage': {
        'en': 'assets/Mathgeometry/circle/circle_e.png',
        'es': 'assets/Mathgeometry/circle/circle_s.png'
      },
    },
    'practice': {
      'questions': [
        {
          'question': 
          {'en': 'What is a circle?',
          'es': '¿Qué es un círculo?'},
          'answers': [
            {'text': {'en': 'A closed shape with straight sides', 'es': 'Una forma cerrada con lados rectos'}, 'correct': false},
            {'text': {'en': 'A closed shape where all points on the boundary are the same distance from the center', 'es': 'Una forma cerrada donde todos los puntos del límite están a la misma distancia del centro'}, 'correct': true},
            {'text': {'en': 'A shape with four right angles', 'es': 'Una figura con cuatro ángulos rectos'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Define the radius of a circle',
          'es': 'Define el radio de un círculo'},
          'answers': [
            {'text': {'en': 'A line that touches the circle at only one point', 'es': 'Una línea que toca el círculo en un solo punto'}, 'correct': false},
            {'text': {'en': 'The distance from the center of the circle to any point on the circle', 'es': 'La distancia desde el centro del círculo hasta cualquier punto del círculo'}, 'correct': true},
            {'text': {'en': 'A part of the circle between two points on the boundary', 'es': 'Una parte del círculo entre dos puntos en el límite'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is the diameter of a circle?',
          'es': '¿Cuál es el diámetro de un círculo?'},
          'answers': [
            {'text': {'en': 'A line segment connecting the center to a point on the boundary', 'es': 'Un segmento de línea que conecta el centro con un punto en el límite'}, 'correct': false},
            {'text': {'en': 'A line segment passing through the center with endpoints on the circle', 'es': 'Un segmento de línea que pasa por el centro con puntos finales en el círculo'}, 'correct': true},
            {'text': {'en': 'The outer boundary of the circle', 'es': 'El límite exterior del círculo'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is the circumference of a circle?',
          'es': '¿Qué es la circunferencia de un círculo?'},
          'answers': [
            {'text': {'en': 'The distance from the center to a point on the circle', 'es': 'La distancia desde el centro hasta un punto del círculo'}, 'correct': false},
            {'text': {'en': 'The total distance around the circle', 'es': 'La distancia total alrededor del círculo'}, 'correct': true},
            {'text': {'en': 'A line segment that connects any two points on the circle and passes through the center', 'es': 'Un segmento de línea que conecta dos puntos cualesquiera en el círculo y pasa por el centro'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which part of the circle connects two points on the boundary?',
          'es': '¿Qué parte del círculo conecta dos puntos en el límite?'},
          'answers': [
            {'text': {'en': 'Tangent', 'es': 'Tangente'}, 'correct': false},
            {'text': {'en': 'Chord', 'es': 'Acorde'}, 'correct': true},
            {'text': {'en': 'Radius', 'es': 'Radio'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is an arc in a circle?',
          'es': '¿Qué es un arco en un círculo?'},
          'answers': [
            {'text': {'en': 'A portion of the circumference between two points', 'es': 'Una porción de la circunferencia entre dos puntos'}, 'correct': true},
            {'text': {'en': 'A line that touches the circle at one point only', 'es': 'Una línea que toca el círculo en un solo punto'}, 'correct': false},
            {'text': {'en': 'A segment passing through the center of the circle from one side to another', 'es': 'Un segmento que pasa por el centro del círculo de un lado a otro'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'What is a tangent?',
          'es': '¿Qué es una tangente?'},
          'answers': [
            {'text': {'en': 'A straight line that touches the circle at exactly one point and does not cross it', 'es': 'Una línea recta que toca el círculo exactamente en un punto y no lo cruza'}, 'correct': true},
            {'text': {'en': 'A curved line that lies entirely inside the circle boundary', 'es': 'Una línea curva que se encuentra completamente dentro del límite del círculo'}, 'correct': false},
            {'text': {'en': 'A line that connects two points inside the circle', 'es': 'Una línea que conecta dos puntos dentro del círculo'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'True or False: A diameter is twice the radius of a circle.',
          'es': 'Verdadero o falso: Un diámetro es el doble del radio de un círculo.'},
          'answers': [
            {'text': {'en': 'True', 'es': 'Verdadero'}, 'correct': true},
            {'text': {'en': 'False', 'es': 'Falso'}, 'correct': false},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'Which part of the circle refers to the straight distance around its boundary?',
          'es': '¿Qué parte del círculo se refiere a la distancia recta alrededor de su límite?'},
          'answers': [
            {'text': {'en': 'Chord', 'es': 'Acorde'}, 'correct': false},
            {'text': {'en': 'Arc', 'es': 'Arco'}, 'correct': false},
            {'text': {'en': 'Circumference', 'es': 'Circunferencia'}, 'correct': true},
          ],
          'questionImage': '',
        },
        {
          'question': 
          {'en': 'How many endpoints does a diameter have?',
          'es': '¿Cuántos puntos finales tiene un diámetro?'},
          'answers': [
            {'text': {'en': '1', 'es': '1'}, 'correct': false},
            {'text': {'en': '2', 'es': '2'}, 'correct': true},
            {'text': {'en': '3', 'es': '3'}, 'correct': false},
          ],
          'questionImage': '',
        },
      ],
    },
    'quiz': {
      'questions': [
        {
          'question':
              {'en': 'You are designing a round wall clock. Which part of circle do the long hand of clock represents?',
              'es': 'Estás diseñando un reloj de pared redondo. ¿Qué parte del círculo representa la manecilla larga del reloj?'},
          'options': {'en': ['Radius', 'Arc', 'Chord'], 'es': ['Radio', 'Arco', 'Acorde']},
          'correctAnswer': {'en': 'Radius', 'es': 'Radio'},
          'hint': {'en': 'It goes from the center to the edge of the circle.', 'es': 'Va desde el centro hasta el borde del círculo.'},
          'questionImage': 'assets/Mathgeometry/circle/q1.png',
        },
        {
          'question':
              {'en': 'A pizza is cut exactly in half from edge to edge through the center. What is the name of the line that makes this cut?',
              'es': 'Una pizza se corta exactamente por la mitad, de borde a borde, pasando por el centro. ¿Cómo se llama la línea que realiza este corte?'},
          'options': {'en': ['Chord', 'Radius', 'Diameter'], 'es': ['Acorde', 'Radio', 'Diámetro']},
          'correctAnswer': {'en': 'Diameter', 'es': 'Diámetro'},
          'hint': {'en': 'It’s the longest line that passes through the center.', 'es': 'Es la línea más larga que pasa por el centro.'},
          'questionImage': 'assets/Mathgeometry/circle/q2.png',
        },
        {
          'question':
              {'en': 'You tie a rope around a circular garden to fence it. What measurement are you calculating?',
              'es': 'Atas una cuerda alrededor de un jardín circular para cercarlo. ¿Qué medida estás calculando?'},
          'options': {'en': ['Diameter', 'Circumference', 'Radius'], 'es': ['Diámetro', 'Circunferencia', 'Radio']},
          'correctAnswer': {'en': 'Circumference', 'es': 'Circunferencia'},
          'hint': {'en': 'It’s the total distance around the circle.', 'es': 'Es la distancia total alrededor del círculo.'},
          'questionImage': 'assets/Mathgeometry/circle/q3.png',
        },
        {
          'question':
              {'en': 'You mark two points on a bicycle wheel and stretch a line straight between them — it doesn’t go through the center. What part of the circle is this?',
              'es': 'Marcas dos puntos en una rueda de bicicleta y trazas una línea recta entre ellos; no pasa por el centro. ¿Qué parte del círculo es esta?'},
          'options': {'en': ['Chord', 'Radius', 'Diameter'], 'es': ['Acorde', 'Radio', 'Diámetro']},
          'correctAnswer': {'en': 'Chord', 'es': 'Acorde'},
          'hint': {'en': 'A straight line between two points that doesn’t pass through the center.', 'es': 'Una línea recta entre dos puntos que no pasa por el centro.'},
          'questionImage': 'assets/Mathgeometry/circle/q4.png',
        },
        {
          'question':
              {'en': 'You see a curved rainbow. What is this curved part called?',
              'es': 'Ves un arcoíris curvo. ¿Cómo se llama esta parte curva?'},
          'options': {'en': ['Arc', 'Tangent', 'Radius'], 'es': ['Arco', 'Tangente', 'Radio']},
          'correctAnswer': {'en': 'Arc', 'es': 'Arco'},
          'hint': {'en': 'It’s a portion of the circle’s curved boundary.', 'es': 'Es una porción del límite curvo del círculo.'},
          'questionImage': 'assets/Mathgeometry/circle/q5.png',
        },
        {
          'question':
              {'en': 'A car tire touches the road at only one point while moving. What do we call the line that just touches the circle at one point?',
              'es': 'Un neumático de coche toca la carretera en un solo punto mientras está en movimiento. ¿Cómo se llama la línea que solo toca el círculo en un punto?'},
          'options': {'en': ['Chord', 'Diameter', 'Tangent'], 'es': ['Acorde', 'Diámetro', 'Tangente']},
          'correctAnswer': {'en': 'Tangent', 'es': 'Tangente'},
          'hint': {'en': 'It touches the circle at one point and never goes inside.', 'es': 'Toca el círculo en un punto y nunca entra.'},
          'questionImage': 'assets/Mathgeometry/circle/q6.png',
        },
        {
          'question':
              {'en': 'A dartboard has lines from the center to the edges dividing it into sections. What are those lines called?',
              'es': 'Una diana tiene líneas que van del centro a los bordes y la dividen en secciones. ¿Cómo se llaman esas líneas?'},
          'options': {'en': ['Radius', 'Chord', 'Tangent'], 'es': ['Radio', 'Acorde', 'Tangente']},
          'correctAnswer': {'en': 'Radius', 'es': 'Radio'},
          'hint': {'en': 'Each line starts from the center and ends on the boundary.', 'es': 'Cada línea comienza en el centro y termina en el límite.'},
          'questionImage': 'assets/Mathgeometry/circle/q7.png',
        },
        {
          'question':
              {'en': 'You place a stick through the center of a round lollipop from one side to the other. What is the stick representing?',
              'es': 'Se introduce un palito por el centro de una piruleta redonda, de un lado a otro. ¿Qué representa el palito?'},
          'options': {'en': ['Radius', 'Diameter', 'Chord'], 'es': ['Radio', 'Diámetro', 'Cuerda']},
          'correctAnswer': {'en': 'Diameter', 'es': 'Diámetro'},
          'hint': {'en': 'It passes through the center, connecting two opposite points.', 'es': 'Pasa por el centro, conectando dos puntos opuestos.'},
          'questionImage': 'assets/Mathgeometry/circle/q8.png',
        },
        {
          'question':
              {'en': 'In a circular racetrack, a runner completes one full round. What distance did they cover?',
              'es': 'En una pista circular, un corredor completa una vuelta. ¿Qué distancia recorrió?'},
          'options': {'en': ['Diameter', 'Radius', 'Circumference'], 'es': ['Diámetro', 'Radio', 'Circunferencia']},
          'correctAnswer': {'en': 'Circumference', 'es': 'Circunferencia'},
          'hint': {'en': 'It’s the total path along the outer edge of the circle.', 'es': 'Es el recorrido total a lo largo del borde exterior del círculo.'},
          'questionImage': 'assets/Mathgeometry/circle/q9.png',
        },
        {
          'question':
              {'en': 'You draw a triangle inside a circle such that each vertex touches the circle. What is the circle called in this case?',
              'es': 'Se dibuja un triángulo dentro de un círculo de modo que cada vértice toque el círculo. ¿Cómo se llama el círculo en este caso?'},
          'options': {'en': ['Circumcircle', 'Arc', 'Tangent'], 'es': ['Circunferencia', 'Arco', 'Tangente']},
          'correctAnswer': {'en': 'Circumcircle', 'es': 'Circuncín'},
          'hint': {'en': 'It’s a circle that passes through all the triangle’s corners.', 'es': 'Es un círculo que pasa por todos los vértices del triángulo.'},
          'questionImage': 'assets/Mathgeometry/circle/q10.png',
        },
      ],
    },
    'section': [
      {
        'title': 'Learn',
        'icon': Icons.book,
        'color': const Color(0xFFFFB400),
        'darkcolor': const Color(0xFFB28704),
        'page': 'learn',
      },
      {
        'title': 'Practice',
        'icon': Icons.lightbulb_outline,
        'color': const Color(0xFFFFB400),
        'darkcolor': const Color(0xFFB28704),
        'page': 'practice',
      },
      {
        'title': 'Quiz',
        'icon': Icons.question_answer_outlined,
        'color': const Color(0xFFFFB400),
        'darkcolor': const Color(0xFFB28704),
        'page': 'quiz',
      },
    ],
  },
];
