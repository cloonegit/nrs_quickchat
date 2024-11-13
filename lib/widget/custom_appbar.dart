import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool? automaticallyImplyLeading;
  final VoidCallback? onPressed;
  final Function()? onback;
  final Icon? icon;

  CustomAppbar({
    Key? key,
    this.automaticallyImplyLeading,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.onback,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomAppbar> createState() => _AppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
        backgroundColor: const Color(0xFFED1C24),
        title: Column(
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.subtitle != null)
              Text(
                widget.subtitle!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          if (widget.icon != null)
            IconButton(
              icon: widget.icon!,
              iconSize: 30,
              onPressed: () {
                widget.onPressed?.call();
              },
            ),
        ]);
  }
}
