import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class GCWPasteButton extends StatefulWidget {
  final Function onSelected;

  const GCWPasteButton({Key key, this.onSelected}) : super(key: key);

  @override
  GCWPasteButtonState createState() => GCWPasteButtonState();
}

class GCWPasteButtonState extends State<GCWPasteButton> {

  final double _BUTTON_SIZE = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _BUTTON_SIZE,
      height: _BUTTON_SIZE,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedBorderRadius),
          side: BorderSide(
            width: 1,
            color: ThemeColors.accent,
          ),
        ),
      ),
      child: PopupMenuButton(
        offset: Offset(0, _BUTTON_SIZE),
        icon: Icon(Icons.content_paste, color: Colors.white, size: 20),
        color: ThemeColors.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedBorderRadius),
        ),
        onSelected: (value) {
          if (value == 0) {
            Clipboard.getData('text/plain').then((data) {
              if (data.text.length == 0) {
                showToast(i18n(context, 'common_clipboard_notextdatafound'));
                return;
              }

              setState(() {
                widget.onSelected(data.text);
                insertIntoGCWClipboard(data.text);
              });
            });
          } else {
            var pasteData = Prefs.getStringList('clipboard_items')[value - 1];
            setState(() {
              widget.onSelected(pasteData);
            });
            insertIntoGCWClipboard(pasteData);
          }
        },
        itemBuilder: (context) => _buildPopupList(),
        padding: EdgeInsets.all(0),
      ),
      margin: EdgeInsets.only(
        bottom: DEFAULT_MARGIN * 2
      )
    );
  }

  _buildPopupList() {
    var popupList = <PopupMenuEntry>[
      PopupMenuItem(
        value: 0,
        child: Text(
          i18n(context, 'common_clipboard_fromdeviceclipboard'),
          style: TextStyle(
            color: Colors.black,
          ),
        )
      ),
      PopupMenuDivider()
    ];

    var gcwClipboard = Prefs.getStringList('clipboard_items')
      .asMap()
      .map((index, clipboardItem) {
        return MapEntry(
          index,
          PopupMenuItem(
            value: index + 1,
            child: Text(
              clipboardItem,
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis
            ),
          )
        );
      })
      .values
      .toList();

    popupList.addAll(gcwClipboard);

    return popupList;
  }
}