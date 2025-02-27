import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/videomodel.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  return _SwiperPanel(
    backdrops: state.backdrops,
    videos: state.videos,
  );
}

class _SwiperPanel extends StatefulWidget {
  final List<VideoResult> videos;
  final List<ImageData> backdrops;
  const _SwiperPanel({this.videos, this.backdrops});
  @override
  _SwiperPanelState createState() => _SwiperPanelState();
}

class _SwiperPanelState extends State<_SwiperPanel> {
  int _currentIndex;
  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  _setCurrectIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    final _width = Adapt.screenW() - _padding * 2;
    final _height = _width * 9 / 16;
    return Container(
      height: _height + Adapt.px(30),
      child: Column(
        children: [
          SizedBox(
            height: _height,
            child: Swiper(
              itemCount: 5,
              onIndexChanged: _setCurrectIndex,
              itemWidth: Adapt.screenW(),
              itemBuilder: (context, index) {
                if (index == 0 && widget.videos.length > 0) {
                  return _VideoCell(
                    videos: widget.videos,
                  );
                }
                return _BackDropCell(
                  data: widget.backdrops.length > index + 1
                      ? widget.backdrops[index]
                      : null,
                );
              },
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          _SwiperPagination(
            lenght: 5,
            currentIndex: _currentIndex,
          ),
        ],
      ),
    );
  }
}

class _SwiperPagination extends StatelessWidget {
  final int lenght;
  final int currentIndex;
  const _SwiperPagination({this.lenght, this.currentIndex});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _cellWidth = Adapt.px(20);
    final _height = Adapt.px(6);
    final _width =
        lenght > 0 ? _cellWidth * lenght + Adapt.px(10) * (lenght - 1) : 0.0;
    return Container(
        width: _width,
        height: _height,
        child: Align(
          alignment: Alignment.center,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(10)),
            itemCount: lenght,
            itemBuilder: (_, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _cellWidth,
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_height / 2),
                  color: index == currentIndex
                      ? _theme.iconTheme.color
                      : _theme.primaryColorDark,
                ),
              );
            },
          ),
        ));
  }
}

class _BackDropCell extends StatelessWidget {
  final ImageData data;
  const _BackDropCell({this.data});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _padding = Adapt.px(40);
    final _width = Adapt.screenW() - _padding * 2;
    final _height = _width * 9 / 16;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _padding),
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: _theme.primaryColorDark,
        borderRadius: BorderRadius.circular(Adapt.px(25)),
        image: data != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(data.filePath, ImageSize.w500),
                ),
              )
            : null,
      ),
    );
  }
}

class _VideoCell extends StatelessWidget {
  final List<VideoResult> videos;
  const _VideoCell({this.videos});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _padding = Adapt.px(40);
    final _width = Adapt.screenW() - _padding * 2;
    final _height = _width * 9 / 16;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: _padding),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            color: _theme.primaryColorDark,
            borderRadius: BorderRadius.circular(Adapt.px(25)),
            image: (videos.length ?? 0) > 0
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        'https://i.ytimg.com/vi/${videos[0]?.key ?? ''}/hqdefault.jpg'),
                  )
                : null,
          ),
          child: Container(
              decoration: BoxDecoration(
            color: const Color(0x55000000),
            borderRadius: BorderRadius.circular(Adapt.px(25)),
          )),
        ),
        Container(
          height: _height,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Adapt.px(50)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: const Color(0x40FFFFFF),
                width: Adapt.px(100),
                height: Adapt.px(100),
                child: Icon(
                  Icons.play_arrow,
                  size: 25,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
