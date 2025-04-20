import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/extensions/string.dart';

class _ImagePlaceHolder extends StatelessWidget {
  _ImagePlaceHolder({this.baseColor})
      : _baseColor = baseColor ?? Colors.grey.shade200;
  final Color? baseColor;
  final Color _baseColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: _baseColor,
          highlightColor: Colors.grey.shade50,
          child: Container(color: Colors.white),
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.image,
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageLoader extends StatelessWidget {
  const ImageLoader(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.radius = 0,
    this.fit,
    this.decoration,
    this.clipBehavior = Clip.none,
  });

  final String image;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit? fit;
  final Decoration? decoration;
  final Clip clipBehavior;

  Clip get _clipBehavior =>
      clipBehavior == Clip.none && radius > 0 ? Clip.hardEdge : clipBehavior;

  String get _image => image.isEmpty
      ? 'https://dummyimage.com/400/f5f5f5/424242&text=Dummy+Image'
      : image;

  Decoration get _decoration =>
      decoration ??
      BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.grey.shade100,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: _decoration,
      clipBehavior: _clipBehavior,
      child: _image.isUrl
          ? CachedNetworkImage(
              imageUrl: _image,
              fit: fit,
              placeholder: (context, url) => _ImagePlaceHolder(),
              errorWidget: (_, __, ___) => Container(
                decoration: _decoration,
                child: Icon(
                  Icons.error,
                  color: Colors.red.shade300,
                ),
              ),
            )
          : _image.pathIsAsset
              ? Image.asset(
                  _image,
                  height: height,
                  width: width,
                  fit: fit,
                )
              : Image.file(
                  File(_image),
                  height: height,
                  width: width,
                  fit: fit,
                ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.url,
    this.name,
    this.dimension = 40.0,
    this.radius = 12.0,
    this.rounded = true,
    this.onTap,
  });

  final String? url;
  final String? name;
  final double dimension;
  final double radius;
  final bool rounded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return CircleAvatar(
        radius: dimension / 2,
        backgroundColor: Colors.grey.shade200,
        child: SizedBox.square(
          dimension: dimension,
          child: Icon(
            Icons.person,
            size: dimension * .7,
            color: Colors.grey.shade400,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: ImageLoader(
        url!,
        width: dimension,
        height: dimension,
        radius: rounded ? dimension / 2 : radius,
      ),
    );
  }
}

class DataLoader extends StatelessWidget {
  const DataLoader({
    super.key,
    this.radius = 12.0,
    this.height,
    this.width,
    this.margin,
    this.baseColor,
    this.highlightColor,
    this.child,
  });

  final double radius;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Color? baseColor;
  final Color? highlightColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          width: width,
          margin: margin,
          child: Shimmer.fromColors(
            baseColor: baseColor ?? Colors.grey.shade200,
            highlightColor: highlightColor ?? Colors.grey.shade100,
            enabled: true,
            child: SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        if (child != null) child!
      ],
    );
  }
}

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            itemBuilder: (_, __) {
              return DataLoader(
                height: 100.0,
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade200,
                child: const Row(
                  children: <Widget>[
                    DataLoader(
                      width: 50.0,
                      height: 50.0,
                      radius: 25.0,
                      margin: EdgeInsets.all(16.0),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DataLoader(
                            width: double.infinity,
                            height: 20.0,
                            radius: 10.0,
                            margin: EdgeInsets.only(right: 40.0, top: 15.0),
                          ),
                          DataLoader(
                            width: double.infinity,
                            height: 15.0,
                            radius: 10.0,
                            margin: EdgeInsets.only(right: 140.0, top: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const DataLoader(
          width: double.infinity,
          height: 50.0,
          margin: EdgeInsets.symmetric(vertical: 15.0),
        )
      ],
    );
  }
}
