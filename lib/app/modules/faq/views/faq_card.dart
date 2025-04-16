import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/clrs.dart';
import '../../../models/faq.dart';
import '../../../widgets/helper.dart';

class FAQCard extends StatefulWidget {
  final FAQModel faq;

  const FAQCard({
    Key? key,
    required this.faq,
  }) : super(key: key);

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(
        () => _isExpanded = !_isExpanded,
      ),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Card(
        elevation: 2.r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 20.r,
                    color: AppClrs.kPrimaryClr,
                  ),
                  addW(8),
                  Expanded(
                    child: Text(
                      widget.faq.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppClrs.kPrimaryClr,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 20.r,
                      color: AppClrs.kPrimaryClr,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ],
              ),
              if (_isExpanded) ...[
                addH(12),
                Text(
                  widget.faq.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.5,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
