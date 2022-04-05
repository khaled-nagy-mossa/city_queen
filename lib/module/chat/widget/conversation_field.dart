import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../common/const/app_data.dart';
import '../../../widget/custom_shadow.dart';

class ConversationField extends StatefulWidget {
  final Future<bool> Function(String value) onSend;
  final bool loadingButton;

  const ConversationField({
    @required this.onSend,
    @required this.loadingButton,
    Key key,
  })  : assert(onSend != null),
        assert(loadingButton != null),
        super(key: key);

  @override
  _ConversationFieldState createState() => _ConversationFieldState();
}

class _ConversationFieldState extends State<ConversationField> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  void _clearFormField() {
    setState(_textController.clear);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Text('icons demo'),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: CustomShadow(
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _textController,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'write here ...',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.loadingButton)
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 40.0,
                        maxHeight: 40.0,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator(),
                    )
                  else
                    GestureDetector(
                      onTap: () async {
                        final sent = await widget.onSend(_textController.text);
                        if (sent) {
                          _clearFormField();
                        }
                      },
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 40.0,
                          maxHeight: 40.0,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SvgPicture.asset(
                          Assets.images.send,
                          width: 30,
                          color: AppData.mainColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
