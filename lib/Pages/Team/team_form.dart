import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Widgets/normal_text_field.dart';
import '/Entity/team.dart';

class TeamForm extends StatelessWidget {

  TeamForm({Key? key, this.doc,}) : super(key: key);

  final DocumentSnapshot? doc;
  final List<TextEditingController> controllerList = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController twitter = TextEditingController();
    TextEditingController instagram = TextEditingController();
    TextEditingController hp = TextEditingController();
    if(_exist()){
      Team team = Team.readDoc(doc!);
      name.text = team.name!;
      twitter.text = team.twitter!;
      instagram.text = team.instagram!;
      hp.text = team.hp!;
    }
    controllerList.add(name);
    controllerList.add(twitter);
    controllerList.add(instagram);
    controllerList.add(hp);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              _delButton(context),
              SizedBox(height: 10),
              NormalTextField(controller: name,label: 'name',),
              SizedBox(height: 10),
              NormalTextField(controller: twitter,label: 'twitter',),
              SizedBox(height: 10),
              NormalTextField(controller: instagram,label: 'instagram',),
              SizedBox(height: 10),
              NormalTextField(controller: hp,label: 'HP',),
              SizedBox(height: 10),
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
          Team.delVideo(doc!.id);
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
          Team t = Team.readController(controllerList);
          t.updateVideo(doc!.id);
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
        onPressed: (){
          Team t = Team.readController(controllerList);
          t.addVideo();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('登録完了'),
              )
          );
        },
      );
    }
  }
}
