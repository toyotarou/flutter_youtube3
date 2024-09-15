enum APIPath {
  getYoutubeCategoryTree,
  getYoutubeList,
  getSpecialVideo,
  getDeletedVideo,
  getBlankBunruiVideo,
  getholiday,
  bunruiYoutubeData,
  updateVideoPlayedAt,
  updateYoutubeCategoryTree,
  oneBunruiInput,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getYoutubeCategoryTree:
        return 'getYoutubeCategoryTree';
      case APIPath.getYoutubeList:
        return 'getYoutubeList';
      case APIPath.getSpecialVideo:
        return 'getSpecialVideo';
      case APIPath.getDeletedVideo:
        return 'getDeletedVideo';
      case APIPath.getBlankBunruiVideo:
        return 'getBlankBunruiVideo';
      case APIPath.getholiday:
        return 'getholiday';

      case APIPath.bunruiYoutubeData:
        return 'bunruiYoutubeData';
      case APIPath.updateVideoPlayedAt:
        return 'updateVideoPlayedAt';
      case APIPath.updateYoutubeCategoryTree:
        return 'updateYoutubeCategoryTree';
      case APIPath.oneBunruiInput:
        return 'oneBunruiInput';
    }
  }
}
