import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

abstract class Model {
  Model(this.endpoint, {this.id});

  int id;
  @JsonKey(ignore: true)
  String endpoint;

  Model fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Note extends Model {
  int id;
  String noteUrl;
  String title;
  int userId;

  Note({this.id, this.noteUrl, this.title, this.userId}) : super("note", id: id);

  @override
  Note fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Role extends Model {
  int id;
  String description;
  int privilege;

  Role({this.id, this.description, this.privilege}) : super("role", id: id);

  @override
  Role fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class GroupUser extends Model {
  int id;
  int groupId;
  int userId;
  int roleId;
  DateTime unRestrictedServerTime;

  GroupUser({this.id, this.groupId, this.userId, this.roleId, this.unRestrictedServerTime})
      : super("group_user", id: id);

  @override
  GroupUser fromJson(Map<String, dynamic> json) => _$GroupUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupUserToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Group extends Model {
  int id;
  String groupName;

  Group({this.id, this.groupName}) : super("group", id: id);

  @override
  Group fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Keyword extends Model {
  int id;
  String description;

  Keyword({this.id, this.description}) : super('keyword', id: id);

  @override
  Keyword fromJson(Map<String, dynamic> json) => _$KeywordFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KeywordToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Message extends Model {
  int id;
  String message;
  DateTime sendServerTime;
  DateTime readServerTime;
  int sender;
  int receiver;
  int groupId;

  Message(
      {this.id,
      this.message,
      this.sendServerTime,
      this.readServerTime,
      this.sender,
      this.receiver,
      this.groupId})
      : super('message', id: id);

  @override
  Message fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Module extends Model {
  int id;
  String imageUrl, title, description;

  Module({this.id, this.imageUrl, this.title, this.description}) : super('module', id: id);

  @override
  Module fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Video extends Model {
  int id;
  String videoUrl, imageUrl;
  String title, description;
  String keywords;
  int parentModuleId;
  int duration;

  Video(
      {this.id,
      this.videoUrl,
      this.imageUrl,
      this.title,
      this.description,
      this.keywords,
      this.parentModuleId,
      this.duration})
      : super('video', id: id);

  @override
  Video fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class History extends Model {
  int id;
  int videoId;
  int currentTime;
  int userId;

  History({this.id, this.videoId, this.currentTime, this.userId}) : super('history', id: id);

  @override
  History fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class User extends Model {
  int id;
  String username, email, phone, password;
  String token, avatar, headerImage;

  User({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.password,
    this.token,
    this.avatar,
    this.headerImage,
  }) : super('user', id: id);

  @override
  User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class VideoComment extends Model {
  int id;
  String comment;
  int userId;
  DateTime submitServerTime;

  VideoComment({this.id, this.comment, this.userId, this.submitServerTime})
      : super('video_comment', id: id);

  @override
  VideoComment fromJson(Map<String, dynamic> json) => _$VideoCommentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoCommentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Post extends Model {
  int id;
  String content;
  DateTime submitServerTime;
  int visibleLevel;
  int userId;
  int parentId;
  int level;

  Post(
      {this.id,
      this.content,
      this.submitServerTime,
      this.visibleLevel,
      this.userId,
      this.parentId,
      this.level})
      : super('post', id: id);

  @override
  Post fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class PostLike extends Model {
  int id;
  int userId;
  int postId;

  PostLike({this.id, this.userId, this.postId}) : super('post_like', id: id);

  @override
  PostLike fromJson(Map<String, dynamic> json) => _$PostLikeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostLikeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Favorite extends Model {
  int id;
  int userId;
  int videoId;
  Favorite({this.id, this.userId, this.videoId}) : super('favorite', id: id);

  @override
  Favorite fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
