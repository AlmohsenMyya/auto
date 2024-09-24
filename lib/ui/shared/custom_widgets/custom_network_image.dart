import 'package:auto2/ui/shared/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? radius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BoxFit boxFit;
  final ColorFilter? colorFilter;
  final Widget? child;
  final BoxShape? shape;
  final AlignmentGeometry alignment;
  final VoidCallback? onTap;

  const CustomNetworkImage(
    this.url, {
    super.key,
    this.radius,
    this.width,
    this.height,
    this.margin,
    this.boxFit = BoxFit.cover,
    this.colorFilter,
    this.shape,
    this.child,
    this.alignment = Alignment.center,
    this.onTap,
  });

  Widget _buildContainer({ImageProvider? imageProvider, Color? color}) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: color,
        borderRadius: shape != null ? null : BorderRadius.circular(radius ?? 10),
        image: imageProvider != null
            ? DecorationImage(
                image: imageProvider,
                fit: boxFit,
                colorFilter: colorFilter,
              )
            : null,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => _buildContainer(imageProvider: imageProvider),
        placeholder: (context, url) => _buildContainer(color:AppColors.mainYellowColor),
        errorWidget: (context, url, error) => _buildContainer(color:AppColors.mainYellowColor),
      ),
    );
  }
}
