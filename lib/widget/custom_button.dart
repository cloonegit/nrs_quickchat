import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String? title;
  final double? titleSize;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? color;
  final Function(String)? onSubmit;
  final BorderRadius? borderRadius;
  final Color? borderSide;
  final FontWeight? fontWeight;
  final String? textNotification;
  final bool? isNotification;

  CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.titleSize,
      this.width,
      this.height,
      this.backgroundColor,
      this.color,
      this.onSubmit,
      this.borderRadius,
      this.borderSide,
      this.fontWeight,
      this.textNotification,
      this.isNotification});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? Adaptive.w(44),
      height: widget.height ?? Adaptive.h(6),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: widget.borderSide ?? Color(0xFFED1C24)),
            backgroundColor: widget.backgroundColor ?? Color(0xFF019949),
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.color ?? Colors.black,
                  fontSize: widget.titleSize ?? 16,
                  fontFamily: 'Poppins',
                  fontWeight: widget.fontWeight ?? FontWeight.w700,
                ),
                overflow: TextOverflow
                    .visible, // or TextOverflow.fade or TextOverflow.visible
              ),
              SizedBox(
                width: Adaptive.w(2),
              ),
              if (widget.isNotification == true)
                CircleAvatar(
                    radius: 10,
                    backgroundColor: Color(0xFFED1C24),
                    child: Text(
                      widget.textNotification ?? '',
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          color: Colors.white),
                    ))
            ],
          )),
    );
  }
}
