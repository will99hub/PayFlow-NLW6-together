import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_Controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "olá,",
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                        text: "${widget.user.name}",
                        style: TextStyles.titleBoldBackground)
                  ],
                ),
                style: TextStyles.titleRegular,
              ),
              subtitle: Text.rich(
                TextSpan(text: "Mantenha suas Contas em dia"),
                style: TextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(widget.user.photoURL!))),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(152),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        )
      ][controller.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  color: controller.currentPage == 0
                      ? AppColors.primary
                      : AppColors.body),
              onPressed: () {
                controller.setPage(0);
                setState(() {});
              },
            ),
            GestureDetector(
              onTap: () {
                print("click");
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, "/barcode_scanner");
                    setState(() {});
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.description_outlined,
                color: controller.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
              onPressed: () {
                controller.setPage(1);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
