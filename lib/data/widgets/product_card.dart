import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColor.grey.withOpacity(0.1), width: 1),
            right: BorderSide(color: AppColor.grey.withOpacity(0.1), width: 1),
            bottom: BorderSide(color: AppColor.grey.withOpacity(0.1), width: 1),
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Card(
          color: AppColor.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: product.images![0],
                  height: getResponsiveHeight(context, 150),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColor.grey.withOpacity(0.3),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CText(
                            textAlign: TextAlign.start,
                            text: product.title.toString(),
                            fontsize: getResponsiveHeight(context, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CText(
                          text: '\$${product.price}',
                          fontsize: getResponsiveHeight(context, 12),
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getResponsiveHeight(context, 4),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: getResponsiveWidth(context, 4),
                        ),
                        CText(
                          text: '${product.rating}',
                          color: AppColor.black,
                          fontsize: getResponsiveHeight(context, 12),
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          width: getResponsiveWidth(context, 4),
                        ),
                        StarRating(
                          rating: double.parse(product.rating.toString()),
                          starSize: getResponsiveHeight(context, 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getResponsiveHeight(context, 4),
                    ),
                    CText(
                      text: 'By ${product.brand}',
                      color: AppColor.grey,
                      fontsize: getResponsiveHeight(context, 12),
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: getResponsiveHeight(context, 6),
                    ),
                    CText(
                      text: 'In ${product.category}',
                      color: AppColor.grey,
                      fontsize: getResponsiveHeight(context, 12),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;

  const StarRating({
    Key? key,
    required this.rating,
    this.starSize = 24.0,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: color, size: starSize);
        } else if (index < rating && rating % 1 != 0) {
          return Icon(Icons.star_half, color: color, size: starSize);
        } else {
          return Icon(Icons.star_border, color: color, size: starSize);
        }
      }),
    );
  }
}
