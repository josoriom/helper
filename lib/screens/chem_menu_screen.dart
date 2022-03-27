import 'package:flutter/material.dart';
import 'package:helper/router/chem_menu_options_router.dart';
import 'package:helper/themes/themes.dart';
import 'package:helper/widgets/home/background.dart';
import 'package:helper/widgets/home/custom_bottom_navigation.dart';

class ChemMenuScreen extends StatelessWidget {
  const ChemMenuScreen({Key? key}) : super(key: key);

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
              leading: Icon(ChemMenuOptions.menuOptions[index].icon,
                  color: AppTheme.primary),
              title: Text(ChemMenuOptions.menuOptions[index].name),
              onTap: () {
                // final route =
                //     MaterialPageRoute(builder: (context) => ListView1Screen());
                // Navigator.push(context, route);

                Navigator.pushNamed(
                    context, ChemMenuOptions.menuOptions[index].route);
              },
            ),
            itemCount: ChemMenuOptions.menuOptions.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
