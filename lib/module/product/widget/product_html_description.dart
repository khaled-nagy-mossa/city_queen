import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../common/service.dart';
import 'package:get/get.dart';

class ProductHtmlDescription extends StatelessWidget {
  final String html;

  ProductHtmlDescription({@required this.html});

  final ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    if (html == null || html.isEmpty) return const SizedBox();
    return GestureDetector(
      onTap: () {
        _expandableController.expanded = !_expandableController.expanded;
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 7,
            )
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          child: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            child: ExpandablePanel(
              controller: _expandableController,
              header: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'More Details'.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              collapsed: Container(
                constraints: const BoxConstraints(maxHeight: 120.0),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: HtmlWidget(AppService.reformatHtmlCode(html)),
                ),
              ),
              expanded: Container(
                constraints: const BoxConstraints(),
                child: HtmlWidget(AppService.reformatHtmlCode(html)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
