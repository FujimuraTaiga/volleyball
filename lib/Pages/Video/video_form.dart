import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Widgets/normal_alert_dialog.dart';
import '/Widgets/date_field.dart';
import '/Widgets/team_select.dart';
import '/Widgets/normal_text_field.dart';
import '/Entity/video.dart';

class VideoForm extends StatelessWidget {

  VideoForm({Key? key, this.doc}) : super(key: key);

  final DocumentSnapshot? doc;
  final List<TextEditingController> controllerList = [];

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    TextEditingController date = TextEditingController();
    TextEditingController set = TextEditingController();
    TextEditingController team = TextEditingController();
    TextEditingController url = TextEditingController();
    if(_exist()){
      Video video = Video.readDoc(doc!);
      date.text = formatter.format(video.date!);
      set.text = '${video.set!}';
      team.text = video.team!;
      url.text = video.formattedURL();
    }
    controllerList.add(date);
    controllerList.add(set);
    controllerList.add(team);
    controllerList.add(url);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              _delButton(context),
              const SizedBox(height: 10),
              DateField(date),
              const SizedBox(height: 10),
              NormalTextField(controller: set,label: 'set',),
              const SizedBox(height: 10),
              TeamSelect(team),
              const SizedBox(height: 10),
              NormalTextField(controller: url,label:'url'),
              const SizedBox(height: 10),
              _button(context),
              TextButton(
                child: const Text('キャンセル'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _exist(){
    return doc != null;
  }

  Widget _delButton(BuildContext context){
    TextEditingController controller = TextEditingController();
    return Visibility(
      visible: _exist(),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const Text('パスワード'),
                  actions: [
                    NormalTextField(controller: controller),
                    TextButton(
                      child: const Text('ok'),
                      onPressed: () {
                        if(controller.text == 'taiga221'){
                          Video.delVideo(doc!.id);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }else{
                          Navigator.pop(context);
                          NormalAlertDialog(context,'パスワードが違います');
                        }
                      }
                    ),
                  ],
                );
              }
          );
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Row(
                children: const [
                  Icon(Icons.delete),
                  Text('削除'),
                ],
              ),
            ]
        ),
      ),
    );
  }

  Widget _button(BuildContext context){
    if(_exist()){
      return ElevatedButton(
        child: const Text('更新'),
        onPressed: (){
          Video v = Video.readController(controllerList);
          v.updateVideo(doc!.id);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('更新完了'),
              )
          );
        },
      );
    }else{
      return ElevatedButton(
        child: const Text('登録'),
        onPressed: () async {
          Video v = Video.readController(controllerList);
          await v.addVideo(context);
        },
      );
    }
  }
}
