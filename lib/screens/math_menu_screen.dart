import 'package:flutter/material.dart';
import 'package:helper/router/math_menu_options_router.dart';
import 'package:helper/themes/themes.dart';

import '../widgets/widgets.dart';

class MathMenuScreen extends StatelessWidget {
  const MathMenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pagina de inicio')),
      ),
      body: Stack(
        children: [
          const Background(),
          ListView.separated(
            itemBuilder: (BuildContext context, int index) => ListTile(
              leading: Icon(MathMenuOptions.menuOptions[index].icon,
                  color: AppTheme.primary),
              title: Text(MathMenuOptions.menuOptions[index].name),
              onTap: () {
                // final route =
                //     MaterialPageRoute(builder: (context) => ListView1Screen());
                // Navigator.push(context, route);

                Navigator.pushNamed(
                    context, MathMenuOptions.menuOptions[index].route);
              },
            ),
            itemCount: MathMenuOptions.menuOptions.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
