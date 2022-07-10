import 'package:db_hive_sample/db/models/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';


ValueNotifier<List <StudentModel>>StudentListnotifier=ValueNotifier([]);

late Database _db;


Future <void> initializeDataBase ()async{
 _db= await openDatabase('student.db',version: 1,onCreate: (Database db, int version)async{
await db.execute('CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
});
}





Future <void> addStudent(StudentModel value)async{

 await _db.rawInsert('INSERT INTO student(name, age ) VALUES (?,?)', [value.name,value.age]);
    getAllStudents();

 
}
Future <void> getAllStudents() async{
  
  final _values=await _db.rawQuery('SELECT * FROM student');
  print(_values);
   StudentListnotifier.value.clear();

   _values.forEach((map) { 
     final student =StudentModel.fromMap(map);
    StudentListnotifier.value.add(student);
     StudentListnotifier.notifyListeners();
   });
  
}

Future <void> deleteStudent(int id) async{
 await _db.rawQuery('DELETE FROM student WHERE id= ?',[id]);
 
 StudentListnotifier.notifyListeners();
  getAllStudents();
}

 Future <void> updateStudent(String name,String age, int id) async{
  await _db.rawUpdate('UPDATE student SET name = ?, age = ? WHERE id = ?',[name,age,id]);
  StudentListnotifier.notifyListeners();
  
   getAllStudents();

 }




 