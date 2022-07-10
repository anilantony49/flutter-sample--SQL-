import 'package:db_hive_sample/db/function/db_functions.dart';
import 'package:db_hive_sample/db/models/data_model.dart';
import 'package:flutter/material.dart';


class ListStudentWidget extends StatelessWidget {
   ListStudentWidget({Key? key}) : super(key: key);
  final namecontroller= TextEditingController();
  final agecontroller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
      ValueListenableBuilder(
        
        valueListenable: StudentListnotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
    
              
                return ListTile(
                  // leading: Icon(Icons.delete),
                  
                 title:  Text(data.name),
                 subtitle: Text(data.age),
              
                 trailing:
                Row(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                           onPressed: () {

                            
                             if (data.id != null) {
                               deleteStudent(data.id!);
                                
                             }else{
                               print('no data id');
                             };
                          
                           
                           },
                           icon: const Icon(
                             Icons.delete,
                             color: Colors.red,
                           )),
                           IconButton(
                            onPressed:()
                   {
                    showDialog(context: (context),
                             builder:(context){
                              return AlertDialog(
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller:namecontroller ,
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        border: OutlineInputBorder()
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: agecontroller,
                                      decoration: InputDecoration(
                                          hintText: 'age',
                                          border: OutlineInputBorder()
                                        ),
                                    ),
                                  ),
                                  TextButton(onPressed: (){
                                 
                                 if(data.id!=null){
                               updateStudent(data.name,data.age, data.id !);
                               
                               }else{
                               print('no update id');
                              }
                               edited();
                                  }, child:Text('Done'))

                                ],
                                title: Text('Edit'),
                              );
                             });
                    
                   },
                    icon: 
                    Icon(Icons.edit,color: Colors.brown,)),
                           
                  ],
                ),
                       
              
                      
                
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider(
                height: 50,
              );
            },
            itemCount: studentList.length,
          );
        },
      );
    
  }

  Future<void>edited()async{
     final name = namecontroller.text.trim();
       final age =  agecontroller.text.trim();
       if (name.isEmpty||age.isEmpty){
         return;
       }
        final student= StudentModel(name: name, age: age);
        
        
           
         addStudent(student);
        
  }
}
