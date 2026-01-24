import 'package:flutter/material.dart';
import 'User_model.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: FutureBuilder<List<User>>(
        future: ApiService.fetchUser(), //ให้ส่งข้อมูลมา
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดผลาดที่main'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              // สร้างรายการแบบไดนามิกตามจำนวนผู้ใช้ที่มี โดยหยิบข้อมูลมาทีละตำแหน่ง (index) เพื่อนำไปแสดงผล

              return Container(
                padding: const EdgeInsets.all(12), //แนวตั้ง|
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,//กว้าง
                      blurRadius: 5,//ฟุ้ง
                      offset: const Offset(0, 3),//ทิศ
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // 1. ตกแต่งรูปภาพให้เป็นวงกลม
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        user.avatar,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15), // ระยะห่างหลังรูปภาพ

                    // 2. ใช้ Column เพื่อจัดกลุ่ม Text ให้ดูง่ายขึ้น
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "ID: ${user.id}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 3. จัดส่วนท้าย (City & Birthdate)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          user.city,
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                        Text(
                          user.birthdate,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),Row(children: [Text('age  ',style: TextStyle(fontSize: 14,),)
                          ,Text(
                          user.age.toString(),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),],)

                        
                      ],
                    ),

                  ],
                ),
              );

            },
          );
        },
      ),
    );
  }
}
