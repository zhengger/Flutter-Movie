import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(CastState state, Dispatch dispatch, ViewService viewService) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 300),
    child: state.casts == null
        ? _ShimmerList()
        : state.casts.length > 0 ? _CastPanel(casts: state.casts) : SizedBox(),
  );
}

class _CastCell extends StatelessWidget {
  final CastData data;
  const _CastCell({this.data});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Column(
      children: [
        Container(
          width: Adapt.px(110),
          height: Adapt.px(110),
          decoration: BoxDecoration(
            color: _theme.primaryColorDark,
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              //alignment: Alignment.topCenter,
              image: CachedNetworkImageProvider(
                ImageUrl.getUrl(data.profilePath, ImageSize.w300),
              ),
            ),
          ),
        ),
        SizedBox(height: Adapt.px(20)),
        SizedBox(
          width: Adapt.px(120),
          child: Text(
            data.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
              fontSize: Adapt.px(22),
              color: const Color(0xFF717171),
            ),
          ),
        )
      ],
    );
  }
}

class _CastPanel extends StatelessWidget {
  final List<CastData> casts;
  const _CastPanel({Key key, @required this.casts})
      : assert(casts != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final _listviewHeight = Adapt.px(230);
    final _padding = Adapt.px(40);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            I18n.of(context).topBilledCast,
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        Container(
          height: _listviewHeight,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(40)),
            itemCount: casts.length,
            itemBuilder: (_, index) {
              final _d = casts[index];
              return _CastCell(
                data: _d,
              );
            },
          ),
        )
      ],
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Adapt.px(110),
          height: Adapt.px(110),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: Adapt.px(20)),
        Container(
          width: Adapt.px(120),
          height: Adapt.px(18),
          color: const Color(0xFFFFFFFF),
        ),
        SizedBox(height: Adapt.px(8)),
        Container(
          width: Adapt.px(80),
          height: Adapt.px(18),
          color: const Color(0xFFFFFFFF),
        )
      ],
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _listviewHeight = Adapt.px(230);
    final _padding = Adapt.px(40);
    final _theme = ThemeStyle.getTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            I18n.of(context).topBilledCast,
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        Container(
          height: _listviewHeight,
          child: Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: _padding),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(40)),
              itemCount: 5,
              itemBuilder: (_, index) {
                return _ShimmerCell();
              },
            ),
          ),
        )
      ],
    );
  }
}
