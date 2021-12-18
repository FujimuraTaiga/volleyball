import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
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
      url.text = video.url!;
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
                child: Text('キャンセル'),
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
    return Visibility(
      visible: _exist(),
      child: InkWell(
        onTap: () {
          Video.delVideo(doc!.id);
          Navigator.pop(context);
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Row(
                children: [
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
        child: Text('更新'),
        onPressed: (){
          Video v = Video.readController(controllerList);
          v.updateVideo(doc!.id);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('更新完了'),
              )
          );
        },
      );
    }else{
      return ElevatedButton(
        child: Text('登録'),
        onPressed: () async {
          Video v = Video.readController(controllerList);
          await v.addVideo(context);
        },
      );
    }
  }
}
