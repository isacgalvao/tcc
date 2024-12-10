import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:transparent_image/transparent_image.dart';

// TODO: Melhorar a implementação do AvatarSkeleton. A classe não desabilita o skeleton quando a imagem é carregada.
class AvatarSkeleton extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const AvatarSkeleton(
    this.imageUrl, {
    super.key,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    if (radius == null || imageUrl.isEmpty) {
      return const SizedBox();
    }

    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: Stack(
          children: [
            Center(
              child: Skeletonizer(
                child: CircleAvatar(
                  radius: radius,
                  child: Skeleton.replace(
                    width: radius! * 2,
                    height: radius! * 2,
                    child: Container(),
                  )
                ),
              ),
            ),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageUrl,
                fit: BoxFit.cover,
                width: radius! * 2,
                height: radius! * 2,
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
