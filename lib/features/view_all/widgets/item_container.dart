import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getit/core/models/item_model.dart';
import 'package:getit/features/home/widgets/constants.dart';
import 'package:getit/features/product/screens/product_screen.dart';
import 'package:getit/features/view_all/widgets/product_image.dart';
import 'package:getit/features/view_all/widgets/product_list_item_image_wrapper.dart';
import 'package:getit/features/view_all/widgets/product_list_item_text.dart';

class ItemContainer extends StatefulWidget {
  const ItemContainer({
    super.key,
    required this.item,
    required this.invert,
  });
  final ItemModel item;
  final bool invert;

  @override
  State<ItemContainer> createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  double productImageRotationAngle = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation,
                    secondaryAnimation) =>
                ProductScreen(product: widget.item),
            transitionDuration:
                const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation,
                secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ));
          // Navigator.of(context).push(CupertinoPageRoute(
          //   builder: (context) => ProductScreen(product: widget.item),
          // ));
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Hero(
                tag: '__recipe_${widget.item.itemName}_image_bg__',
                child: Container(
                  alignment: Alignment.centerLeft,
                  // height: 115.h,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.white.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  // child: RecipeListItemImage(recipe),
                ),
              ),
            ),
            Positioned.fill(
              right: widget.invert ? null : 35.w,
              left: widget.invert ? 15.w : null,
              top: 0.h,
              child: Container(
                alignment: Alignment.centerRight,
                child: ProductListItemImageWrapper(
                  invert: widget.invert,
                  child: ProductImage(
                    widget.item,
                    imageRotationAngle: productImageRotationAngle,
                    imageSize: 150.h,
                    alignment: Alignment.centerRight,
                    hasShadow: false,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                if (widget.invert) Expanded(flex: 5, child: Container()),
                Expanded(
                  flex: 4,
                  child: ProductListItemText(widget.item),
                ),
                if (!widget.invert) Expanded(flex: 2, child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
