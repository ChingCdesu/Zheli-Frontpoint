import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/crypto.dart';

// 登录
Future<API.User> loginAsync(String username, String password) async {
  // 建立一个 User 的档案（对象）
  API.User _u = new API.User(
    username: username,
    password: generateMd5(password), // 对密码进行 md5 加密
  );
  // 登录使用 Confirm 接口
  var operation = await API.Confirm(_u).doOperation();
  // 判断是否有错误
  if (operation.hasError) {
    print(operation.log); // 有错打印日志
    return null;
  } else {
    // 将 UserID 写入静态变量，token 为自动写入
    Account.userId = operation.getResult()['values'][0]['ID'];
    operation = await API.Get(new API.User(id: Account.userId)).doOperation();
    return operation.getResult();
  }
}

// 获取模块的视频列表(模块id)
Future<List> getVideosByModuleIdAsync(int moduleId) async {
  // 用于存放 video 信息
  List<API.Video> videos = new List();

  API.Video _v = new API.Video(parentModuleId: moduleId);
  var operation = await API.Confirm(_v).doOperation();
  if (operation.hasError) {
    print(operation.log);
  } else {
    var ids = operation.getResult()['values'];
    for (var videoId in ids) {
      final id = videoId['ID'];
      _v = new API.Video(id: id);
      operation = await API.Get(_v).doOperation();
      if (operation.hasError) {
        print(operation.log);
      } else {
        videos.add(operation.getResult());
      }
    }
  }
  return videos.length == 0 ? null : videos;
}

class VideoCommentUserView {
  API.User user;
  API.Video video;
  API.VideoComment comment;
  @override
  String toString() {
    return '{ user: ${user.toString()}, video: ${video.toString()}, comment: ${comment.toString()} }';
  }
}

// 获取视频的评论列表(视频id)
Future<List> getCommentsByVideoIdAsync(int videoId) async {
  List<VideoCommentUserView> comments = new List();

  API.VideoComment comment = new API.VideoComment(videoId: videoId);
  var operation = await API.Confirm(comment).doOperation();
  if (operation.hasError) {
    print(operation.log);
  } else {
    var ids = operation.getResult()['values'];
    for (var commentId in ids) {
      final id = commentId['ID'];
      VideoCommentUserView view = new VideoCommentUserView();

      operation = await API.Get(new API.VideoComment(id: id)).doOperation();
      view.comment = operation.getResult();

      operation = await API.Get(new API.Video(id: view.comment.videoId)).doOperation();
      view.video = operation.getResult();

      operation = await API.Get(new API.User(id: view.comment.userId)).doOperation();
      view.user = operation.getResult();

      comments.add(view);
    }
  }
  return comments.length == 0 ? null : comments;
}

// 注册
Future<API.User> registAsync(String username, String password) async {
  API.User _u = new API.User(
    username: username,
    password: generateMd5(password), // 对密码进行 md5 加密
  );
  var operation = await API.Create(_u).doOperation();
  if (operation.hasError) {
    print(operation.log);
    return null;
  } else {
    _u.id = operation.getResult()['data']['id'];
    return _u;
  }
}

// TODO: 待完成
// 添加视频评论
Future<bool> createCommentsAsync(API.VideoComment comment) async {}
// 获取用户的动态(用户id)
Future<List> getPostsByUserIdAsync(int userId) async {}
// 添加动态
Future<bool> createPostAsync(API.Post post) async {}
// 给动态点赞
Future<bool> createPostLikeAsync(API.PostLike link) async {}
// 获取动态的赞(动态id)
Future<List> getPostLikesByPostIdAsync(int postId) async {}
