import 'package:flutter/material.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';

class InfoList extends StatelessWidget {
  final List<ListDataObject> data;

  InfoList(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(crossAxisCount: 2, children: getListChildren()));
  }

  getListChildren() {
    return List.generate(data.length, (index) {
      return InkWell(
          onTap: () => {Utils.openUrl(data[index].url)},
          child: SizedBox(
              height: clients_item_height,
              child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(common_margin),
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Color(grayFilter),
                            BlendMode.srcATop,
                          ),
                          child: Image.asset(
                            data[index].imagePath,
                            fit: BoxFit.contain,
                          ))))));
    });
  }
}

class ListDataObject {
  String url;
  String imagePath;

  ListDataObject(this.url, this.imagePath);
}
