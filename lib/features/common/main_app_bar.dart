import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        child: Container(
          height: 1.0,
        ),
        preferredSize: const Size.fromHeight(1.0),
      ),
      shadowColor: Colors.transparent,
      title: const Center(
        child: Text(
          "APP",
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          iconSize: 32,
          onPressed: () => {},
        ),
      ],
    );
  }
}
