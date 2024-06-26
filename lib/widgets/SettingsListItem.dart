import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsListItem extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final void Function() onTap;
  final bool links;
  SettingsListItem(this.iconData, this.title, this.onTap,
      {super.key, this.links = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            decoration: (links == false)
                ? const BoxDecoration(border: Border(bottom: BorderSide()))
                : null,
            child: Padding(
              padding: (links == false)
                  ? const EdgeInsets.symmetric(vertical: 15)
                  : const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  (iconData != null)
                      ? Icon(
                          iconData,
                        )
                      : SizedBox(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.w,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
