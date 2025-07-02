// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      isAnonymous: json['isAnonymous'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastSignInAt: json['lastSignInAt'] == null
          ? null
          : DateTime.parse(json['lastSignInAt'] as String),
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'isAnonymous': instance.isAnonymous,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'isEmailVerified': instance.isEmailVerified,
    };
