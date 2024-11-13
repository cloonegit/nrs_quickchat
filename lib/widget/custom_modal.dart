import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomModal extends StatefulWidget {
  final String? staffCode;
  final String? title;
  final String? subtitle;
  final VoidCallback onNext;
  final VoidCallback? onCancel;
  final VoidCallback? onClose;
  final bool? isImagePresent;
  final String? button;
  final String? button2;
  final bool? isCloseButton;

  CustomModal(
      {Key? key,
      this.staffCode,
      this.title,
      this.subtitle,
      this.isImagePresent,
      this.button,
      this.button2,
      this.isCloseButton,
      required this.onNext,
      this.onCancel,
      this.onClose})
      : super(key: key);

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: widget.isCloseButton == true
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      // FocusScope.of(context).unfocus();
                      widget.onClose!();
                      Navigator.of(context).pop();
                    },
                  )
                : SizedBox(
                    height: Adaptive.h(4),
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                if (widget.title != null && widget.title!.isNotEmpty)
                  Text(
                    widget.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                SizedBox(height: 8),
                if (widget.staffCode != null && widget.staffCode!.isNotEmpty)
                  Text(
                    widget.staffCode ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (widget.subtitle != null && widget.subtitle!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.subtitle ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                // if (widget.isImagePresent == true)
                //   SizedBox(height: Adaptive.h(0)),
                if (widget.isImagePresent == true)
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/quick_chat.png',
                      height: 150,
                      // width: 100,
                    ),
                  ),
                const SizedBox(height: 30),
                if (widget.button2 != null && widget.button2!.isNotEmpty)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xFFEA1C24),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                      widget.onCancel!();
                    },
                    child: Text(
                      widget.button2 ?? 'NO',
                      style: const TextStyle(
                        color: Color(0xFFEA1C24),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: Adaptive.h(1)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEA1C24),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onNext();
                  },
                  child: Text(
                    widget.button ?? 'NEXT',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Adaptive.h(3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
