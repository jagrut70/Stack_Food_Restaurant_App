import 'package:efood_multivendor_restaurant/controller/addon_controller.dart';
import 'package:efood_multivendor_restaurant/data/model/response/product_model.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_button.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_restaurant/view/base/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddonBottomSheet extends StatefulWidget {
  final AddOns addon;
  AddAddonBottomSheet({@required this.addon});

  @override
  State<AddAddonBottomSheet> createState() => _AddAddonBottomSheetState();
}

class _AddAddonBottomSheetState extends State<AddAddonBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _priceNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if(widget.addon != null) {
      _nameController.text = widget.addon.name;
      _priceController.text = widget.addon.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_LARGE)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        MyTextField(
          hintText: 'addon_name'.tr,
          controller: _nameController,
          focusNode: _nameNode,
          nextFocus: _priceNode,
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

        MyTextField(
          hintText: 'price'.tr,
          controller: _priceController,
          focusNode: _priceNode,
          inputAction: TextInputAction.done,
          inputType: TextInputType.number,
          isAmount: true,
          amountIcon: true,
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

        GetBuilder<AddonController>(builder: (addonController) {
          return !addonController.isLoading ? CustomButton(
            onPressed: () {
              String _name = _nameController.text.trim();
              String _price = _priceController.text.trim();
              if(_name.isEmpty) {
                showCustomSnackBar('enter_addon_name'.tr);
              }else if(_price.isEmpty) {
                showCustomSnackBar('enter_addon_price'.tr);
              }else {
                AddOns _addon = AddOns(name: _name, price: double.parse(_price));
                if(widget.addon != null) {
                  _addon.id = widget.addon.id;
                  addonController.updateAddon(_addon);
                }else {
                  addonController.addAddon(_addon);
                }
              }
            },
            buttonText: widget.addon != null ? 'update'.tr : 'submit'.tr,
          ) : Center(child: CircularProgressIndicator());
        }),

      ]),
    );
  }
}
