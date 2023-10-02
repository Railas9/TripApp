import 'package:flutter/material.dart';


Future<String?> askModal(BuildContext context, String question){
  return Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (context,_,__){
         return AskModal(question: question);
  }));
}

class AskModal extends StatelessWidget {
  final String question;
  const AskModal({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black38,
        alignment: Alignment.center,
        child: Card(
          child: Container(
            height: 300,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(question, style: const TextStyle(fontSize: 25)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                        onPressed: (){
                      Navigator.pop(context, "ok");
                      },
                        child: const Text("ok", style: TextStyle(color: Colors.white))
                    ),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                        onPressed: (){
                      Navigator.pop(context, "annuler");
                    },
                        child: const Text("annuler", style: TextStyle(color: Colors.white))
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}
