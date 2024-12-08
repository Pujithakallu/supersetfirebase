import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference studyMaterialCollection =
  FirebaseFirestore.instance.collection('studymaterial');

  Future<List<Map<String, String>>> getChapterData(String chapter) async {
    try {
      DocumentSnapshot chapterSnapshot = await studyMaterialCollection
          .doc('chapters')
          .collection(chapter)
          .doc('content')
          .get();

      Map<String, dynamic> chapterData =
      chapterSnapshot.data() as Map<String, dynamic>;

      List<Map<String, String>> numbersData = [];

      chapterData['translations'].forEach((key, value) {
        numbersData.add({'english': key, 'spanish': value});
      });

      return numbersData;
    } catch (e) {
      print('Error fetching chapter data: $e');
      return [];
    }
  }
}

Future<void> enterChapterData(
    FirebaseFirestore firestore, String chapter, Map<String, String> translations) async {
  try {
    await firestore.collection('study_material').doc('chapters').collection(chapter).doc('content').set({
      'translations': translations,
    });

    print('Data for $chapter inserted successfully!');
  } catch (e) {
    print('Error inserting data for $chapter: $e');
  }
}

void main() async {
  final firestore = FirebaseFirestore.instance;

  await enterChapterData(firestore, 'chapter1', {
    'one': 'uno',
    'two': 'dos',
    'three': 'tres',
    'four': 'cuatro',
    'five': 'cinco',
    'six': 'seis',
    'seven': 'siete',
    'eight': 'ocho',
    'nine': 'nueve',
    'ten': 'diez',
  });

  print('Chapter data inserted successfully!');

  // You can repeat the process for other chapters when data becomes available
}
