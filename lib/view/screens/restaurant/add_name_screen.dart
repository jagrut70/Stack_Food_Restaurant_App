import 'package:efood_multivendor_restaurant/controller/splash_controller.dart';
import 'package:efood_multivendor_restaurant/data/model/response/config_model.dart';
import 'package:efood_multivendor_restaurant/data/model/response/product_model.dart';
import 'package:efood_multivendor_restaurant/helper/route_helper.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_button.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_restaurant/view/base/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNameScreen extends StatefulWidget {
  final Product product;
  AddNameScreen({@required this.product});

  @override
  _AddNameScreenState createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  List<TextEditingController> _nameControllerList = [];
  List<TextEditingController> _descriptionControllerList = [];
  List<FocusNode> _nameFocusList = [];
  List<FocusNode> _descriptionFocusList = [];
  List<Language> _languageList = Get.find<SplashController>().configModel.language;

  @override
  void initState() {
    super.initState();

    _languageList.forEach((element) {
      _nameControllerList.add(TextEditingController(text: widget.product != null ? widget.product.name : ''));
      _descriptionControllerList.add(TextEditingController(text: widget.product != null ? widget.product.description ?? '' : ''));
      _nameFocusList.add(FocusNode());
      _descriptionFocusList.add(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.product != null ? 'update_food'.tr : 'add_food'.tr),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(children: [

          Expanded(child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _languageList.length,
            itemBuilder: (context, index) {
              return Column(children: [

                Text(_languageList[index].value, style: robotoBold),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                MyTextField(
                  hintText: 'food_name'.tr,
                  controller: _nameControllerList[index],
                  capitalization: TextCapitalization.words,
                  focusNode: _nameFocusList[index],
                  nextFocus: _descriptionFocusList[index],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                MyTextField(
                  hintText: 'description'.tr,
                  controller: _descriptionControllerList[index],
                  focusNode: _descriptionFocusList[index],
                  capitalization: TextCapitalization.sentences,
                  maxLines: 5,
                  inputAction: index != _languageList.length-1 ? TextInputAction.next : TextInputAction.done,
                  nextFocus: index != _languageList.length-1 ? _nameFocusList[index+1] : null,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              ]);
            },
          )),

          CustomButton(
            buttonText: 'next'.tr,
            onPressed: () {
              bool _defaultDataNull = false;
              for(int index=0; index<_languageList.length; index++) {
                if(_languageList[index].key == 'en') {
                  if (_nameControllerList[index].text.trim().isEmpty || _descriptionControllerList[index].text.trim().isEmpty) {
                    _defaultDataNull = true;
                  }
                  break;
                }
              }
              if(_defaultDataNull) {
                showCustomSnackBar('enter_data_for_english'.tr);
              }else {
                List<Language> _nameList = [];
                List<Language> _descriptionList = [];
                for(int index=0; index<_languageList.length; index++) {
                  _nameList.add(Language(key: _languageList[index].key, value: _nameControllerList[index].text.trim()));
                  _descriptionList.add(Language(key: _languageList[index].key, value: _descriptionControllerList[index].text.trim()));
                }
                Get.toNamed(RouteHelper.getAddProductRoute(widget.product, _nameList, _descriptionList));
              }
            },
          ),

        ]),
      ),
    );
  }
}
