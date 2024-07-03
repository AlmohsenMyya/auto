import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/views/wellcom_screen/centers/centers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CentersScreen extends StatefulWidget {
  @override
  State<CentersScreen> createState() => _CentersScreenState();
}

class _CentersScreenState extends State<CentersScreen> {
  late final CentersController controller;

  @override
  void initState() {
    controller = Get.put(CentersController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      appBar: AppBar(
        backgroundColor: context.exOnPrimaryContainer,
        leading: Image.asset(
          "assets/images/logo.png",
          height: 50,
        ),
        actions: [
          Image.asset(
            "assets/images/logo.png",
            height: 50,
          ),
        ],
        title: Center(child: Text("مراكز البيع")),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: [

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.cities.length,
                itemBuilder: (context, index) {
                  final city = controller.cities[index];
                  return ListTile(
                    title: Text(city.name),
                    onTap: () {
                      controller.selectCity(city.id);
                      Get.to(() => LibrariesScreen());
                    },
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}

class LibrariesScreen extends StatelessWidget {
  final CentersController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      appBar: AppBar(
        backgroundColor: context.exOnPrimaryContainer,
        title: Text('المكتبات في المدينة'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.selectedCityLibraries.length,
          itemBuilder: (context, index) {
            final library = controller.selectedCityLibraries[index];
            return ListTile(
              title: Text(library.name),
            );
          },
        );
      }),
    );
  }
}
