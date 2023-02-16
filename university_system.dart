import 'dart:io';

main() {
  Student student1 = Student();
  student1.firstName = 'ali';
  student1.lastName = 'aliyev';
  student1.age = 17;
  student1.point = 78;
  student1.isStudent = true;

  Student student2 = Student();
  student2.firstName = 'Mahmud';
  student2.lastName = 'Mammadov';
  student2.age = 28;
  student2.point = 97;
  student2.isStudent = false;

  Student student3 = Student();
  student3.firstName = 'Sanan';
  student3.lastName = 'Aslanov';
  student3.age = 21;
  student3.point = 65;
  student3.isStudent = true;

  List<Student> students = [
    student1,
    student2,
    student3
  ];

  Admin admin1 = new Admin();
  admin1.userName = 'rashad';
  admin1.password = '123';

  Admin admin2 = new Admin();
  admin2.userName = 'polad';
  admin2.password = '321';
  List<Admin> admins = [
    admin1,
    admin2
  ];
  Teacher teacher1 = new Teacher();
  Teacher teacher2 = new Teacher();
  teacher1.userName = 'Nigar';
  teacher1.password = '123';
  teacher2.userName = 'Ruslan';
  teacher2.password = '123';
  List<Teacher> teachers = [
    teacher1,
    teacher2
  ];

  print("Are you admin[1] or teacher[2]?");
  int answer = int.parse(stdin.readLineSync()!);
  if (answer == 1) {
    print("Hello admin");
    print("enter username");
    String userName = stdin.readLineSync()!;
    print("enter password");
    String code = stdin.readLineSync()!;
    CheckValidity(userName, code, admins);
    print('Do you want to add student?[y/n]');
    String cavab = stdin.readLineSync()!;
    if (cavab == 'y') {
      while (cavab == 'y') {
        CreateStudent(students);
        print('Do you want to add new student?[y/n]');
        cavab = stdin.readLineSync()!;
      }
    } else {
      printStudents(students);
    }

    print("If you want to see current student press [1] or graduated students press[2]");
    int answerNum = int.parse(stdin.readLineSync()!);
    CurrentStudents(answerNum, students);

    stdout.write('Average of the student is: ');
    num averagePoint = FindAverage(students);
    print(averagePoint);
  } else {
    print("Hello Teacher");
    print("enter username");
    String userName = stdin.readLineSync()!;
    print("enter password");
    String code = stdin.readLineSync()!;
    CheckValidity(userName, code, teachers);
    print("here is your students average score:");
    print(FindAverage(students));
    print("Do you want delete student?[y/n]");
    String answer = stdin.readLineSync()!;
    if (answer == 'y') {
      print("enter student's name which you want to remove");
      String removedStudent = stdin.readLineSync()!;
      if (RemoveStudent(students, removedStudent)) {
        print("$removedStudent is deleted from list");
      } else {
        print("There is no such a kind of student");
      }

      printStudents(students);
    }
  }
}

printStudents(List<Student> students) {
  for (var i = 0; i < students.length; i++) {
    students[i].printStudent();
  }
}

CreateStudent(List<Student> students) {
  Student newStudent = Student();
  newStudent.firstName = stdin.readLineSync()!;
  newStudent.lastName = stdin.readLineSync()!;
  newStudent.age = int.parse(stdin.readLineSync()!);
  newStudent.point = int.parse(stdin.readLineSync()!);
  newStudent.isStudent = int.parse(stdin.readLineSync()!) == 1 ? true : false;
  students.add(newStudent);
}

bool RemoveStudent(List<Student> students, String name) {
  for (int i = 0; i < students.length; i++) {
    if (students[i].firstName == name) {
      students.remove(students[i]);
      return true;
    }
  }
  return false;
}

CheckValidity(String userName, String password, List users) {
  bool flag = false;
  for (int i = 0; i < users.length; i++) {
    if (users[i].userName == userName && users[i].password == password) {
      flag = true;
      print('succesful');
      break;
    }
  }
  if (flag == false) {
    print('username or password is incorrect');
    print("do you want to try again? - [y/n]");
    String? cavab = stdin.readLineSync();
    if (cavab == "y") {
      main();
    } else {
      return;
    }
  }
}

CurrentStudents(int answerNum, List students) {
  if (answerNum == 1) {
    students.forEach((element) {
      if (element.isStudent == true) {
        element.printStudent();
      }
    });
  } else {
    students.forEach((element) {
      if (element.isStudent == false) {
        element.printStudent();
      }
    });
  }
}

num FindAverage(List students) {
  num sumOfPoint = 0;

  for (int i = 0; i < students.length; i++) {
    sumOfPoint = sumOfPoint + students[i].point;
  }
  return sumOfPoint / (students.length);
}

class Student {
  String firstName = '';
  String lastName = '';
  int age = 0;
  int point = 0;
  bool isStudent = false;

  printStudent() {
    print("Name: $firstName, lastName: $lastName, age: $age, is Student?-$isStudent point: $point");
  }
}

class Admin {
  late String userName;
  late String password;
}

class Teacher {
  late String userName;
  late String password;
}
