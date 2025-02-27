import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';

class TvShowDetailState implements Cloneable<TvShowDetailState> {
  GlobalKey<ScaffoldState> scaffoldkey;
  TVDetailModel tvDetailModel;
  int tvid;
  String name;
  String posterPic;
  CreditsModel creditsModel;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoListModel recommendations;
  KeyWordModel keywords;
  VideoModel videomodel;
  String backdropPic;
  Color mainColor;
  Color tabTintColor;
  AccountState accountState;
  @override
  TvShowDetailState clone() {
    return TvShowDetailState()
      ..scaffoldkey = scaffoldkey
      ..tvDetailModel = tvDetailModel
      ..mainColor = mainColor
      ..tabTintColor = tabTintColor
      ..creditsModel = creditsModel
      ..tvid = tvid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..recommendations = recommendations
      ..keywords = keywords
      ..videomodel = videomodel
      ..backdropPic = backdropPic
      ..posterPic = posterPic
      ..name = name
      ..accountState = accountState;
  }
}

TvShowDetailState initState(Map<String, dynamic> args) {
  TvShowDetailState state = TvShowDetailState();
  state.scaffoldkey =
      GlobalKey<ScaffoldState>(debugLabel: '_TvShowDetailPagekey');
  state.tvid = args['tvid'];
  if (args['bgpic'] != null) state.backdropPic = args['bgpic'];
  if (args['posterpic'] != null) state.posterPic = args['posterpic'];
  if (args['name'] != null) state.name = args['name'];
  state.tvDetailModel = new TVDetailModel.fromParams();
  state.creditsModel = new CreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());

  state.imagesmodel = new ImageModel.fromParams(
      posters: List<ImageData>(), backdrops: List<ImageData>());
  state.reviewModel = new ReviewModel.fromParams(results: List<ReviewResult>());
  state.recommendations =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  state.keywords = new KeyWordModel.fromParams(
      keywords: List<KeyWordData>(), results: List<KeyWordData>());
  state.videomodel = new VideoModel.fromParams(results: List<VideoResult>());
  state.accountState = AccountState.fromParams(
      id: 0,
      uid: GlobalStore.store.getState().user?.firebaseUser?.uid,
      mediaId: state.tvid,
      favorite: false,
      watchlist: false,
      mediaType: 'tv');
  return state;
}
