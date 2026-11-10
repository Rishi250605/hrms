// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BuRef {

 String get id; String get code; String get name; bool get isPrimary;
/// Create a copy of BuRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuRefCopyWith<BuRef> get copyWith => _$BuRefCopyWithImpl<BuRef>(this as BuRef, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BuRef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuRef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.isPrimary, _this.isPrimary) || other.isPrimary == _this.isPrimary));
}


@override
int get hashCode {
  final _this = this as BuRef;
  return Object.hash(runtimeType,_this.id,_this.code,_this.name,_this.isPrimary);
}

@override
String toString() {
  final _this = this as BuRef;
  return 'BuRef(id: ${_this.id}, code: ${_this.code}, name: ${_this.name}, isPrimary: ${_this.isPrimary})';
}


}

/// @nodoc
abstract mixin class $BuRefCopyWith<$Res>  {
  factory $BuRefCopyWith(BuRef value, $Res Function(BuRef) _then) = _$BuRefCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name, bool isPrimary
});




}
/// @nodoc
class _$BuRefCopyWithImpl<$Res>
    implements $BuRefCopyWith<$Res> {
  _$BuRefCopyWithImpl(this._self, this._then);

  final BuRef _self;
  final $Res Function(BuRef) _then;

/// Create a copy of BuRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? isPrimary = null,}) {
  return _then(BuRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BuRef].
extension BuRefPatterns on BuRef {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuRef() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuRef value)  $default,){
final _that = this;
switch (_that) {
case _BuRef():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuRef value)?  $default,){
final _that = this;
switch (_that) {
case _BuRef() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name,  bool isPrimary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuRef() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.isPrimary);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name,  bool isPrimary)  $default,) {final _that = this;
switch (_that) {
case _BuRef():
return $default(_that.id,_that.code,_that.name,_that.isPrimary);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name,  bool isPrimary)?  $default,) {final _that = this;
switch (_that) {
case _BuRef() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.isPrimary);case _:
  return null;

}
}

}

/// @nodoc


class _BuRef implements BuRef {
  const _BuRef({required this.id, required this.code, required this.name, this.isPrimary = false});
  

@override final  String id;
@override final  String code;
@override final  String name;
@override@JsonKey() final  bool isPrimary;

/// Create a copy of BuRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuRefCopyWith<_BuRef> get copyWith => __$BuRefCopyWithImpl<_BuRef>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuRef&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,code,name,isPrimary);
}

@override
String toString() {
    return 'BuRef(id: $id, code: $code, name: $name, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class _$BuRefCopyWith<$Res> implements $BuRefCopyWith<$Res> {
  factory _$BuRefCopyWith(_BuRef value, $Res Function(_BuRef) _then) = __$BuRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name, bool isPrimary
});




}
/// @nodoc
class __$BuRefCopyWithImpl<$Res>
    implements _$BuRefCopyWith<$Res> {
  __$BuRefCopyWithImpl(this._self, this._then);

  final _BuRef _self;
  final $Res Function(_BuRef) _then;

/// Create a copy of BuRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? isPrimary = null,}) {
  return _then(_BuRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CurrentUser {

 String get id; String get employeeId; String get empCode; String get name; String get phone; String? get email; UserRole get role; List<BuRef> get businessUnits; String? get reportingToName; String? get reportingToCode; UserRole? get reportingToRole;
/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<CurrentUser> get copyWith => _$CurrentUserCopyWithImpl<CurrentUser>(this as CurrentUser, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CurrentUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.employeeId, _this.employeeId) || other.employeeId == _this.employeeId)&&(identical(other.empCode, _this.empCode) || other.empCode == _this.empCode)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&const DeepCollectionEquality().equals(other.businessUnits, _this.businessUnits)&&(identical(other.reportingToName, _this.reportingToName) || other.reportingToName == _this.reportingToName)&&(identical(other.reportingToCode, _this.reportingToCode) || other.reportingToCode == _this.reportingToCode)&&(identical(other.reportingToRole, _this.reportingToRole) || other.reportingToRole == _this.reportingToRole));
}


@override
int get hashCode {
  final _this = this as CurrentUser;
  return Object.hash(runtimeType,_this.id,_this.employeeId,_this.empCode,_this.name,_this.phone,_this.email,_this.role,const DeepCollectionEquality().hash(_this.businessUnits),_this.reportingToName,_this.reportingToCode,_this.reportingToRole);
}

@override
String toString() {
  final _this = this as CurrentUser;
  return 'CurrentUser(id: ${_this.id}, employeeId: ${_this.employeeId}, empCode: ${_this.empCode}, name: ${_this.name}, phone: ${_this.phone}, email: ${_this.email}, role: ${_this.role}, businessUnits: ${_this.businessUnits}, reportingToName: ${_this.reportingToName}, reportingToCode: ${_this.reportingToCode}, reportingToRole: ${_this.reportingToRole})';
}


}

/// @nodoc
abstract mixin class $CurrentUserCopyWith<$Res>  {
  factory $CurrentUserCopyWith(CurrentUser value, $Res Function(CurrentUser) _then) = _$CurrentUserCopyWithImpl;
@useResult
$Res call({
 String id, String employeeId, String empCode, String name, String phone, String? email, UserRole role, List<BuRef> businessUnits, String? reportingToName, String? reportingToCode, UserRole? reportingToRole
});




}
/// @nodoc
class _$CurrentUserCopyWithImpl<$Res>
    implements $CurrentUserCopyWith<$Res> {
  _$CurrentUserCopyWithImpl(this._self, this._then);

  final CurrentUser _self;
  final $Res Function(CurrentUser) _then;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeId = null,Object? empCode = null,Object? name = null,Object? phone = null,Object? email = freezed,Object? role = null,Object? businessUnits = null,Object? reportingToName = freezed,Object? reportingToCode = freezed,Object? reportingToRole = freezed,}) {
  return _then(CurrentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,empCode: null == empCode ? _self.empCode : empCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,businessUnits: null == businessUnits ? _self.businessUnits : businessUnits // ignore: cast_nullable_to_non_nullable
as List<BuRef>,reportingToName: freezed == reportingToName ? _self.reportingToName : reportingToName // ignore: cast_nullable_to_non_nullable
as String?,reportingToCode: freezed == reportingToCode ? _self.reportingToCode : reportingToCode // ignore: cast_nullable_to_non_nullable
as String?,reportingToRole: freezed == reportingToRole ? _self.reportingToRole : reportingToRole // ignore: cast_nullable_to_non_nullable
as UserRole?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentUser].
extension CurrentUserPatterns on CurrentUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentUser value)  $default,){
final _that = this;
switch (_that) {
case _CurrentUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentUser value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String employeeId,  String empCode,  String name,  String phone,  String? email,  UserRole role,  List<BuRef> businessUnits,  String? reportingToName,  String? reportingToCode,  UserRole? reportingToRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that.id,_that.employeeId,_that.empCode,_that.name,_that.phone,_that.email,_that.role,_that.businessUnits,_that.reportingToName,_that.reportingToCode,_that.reportingToRole);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String employeeId,  String empCode,  String name,  String phone,  String? email,  UserRole role,  List<BuRef> businessUnits,  String? reportingToName,  String? reportingToCode,  UserRole? reportingToRole)  $default,) {final _that = this;
switch (_that) {
case _CurrentUser():
return $default(_that.id,_that.employeeId,_that.empCode,_that.name,_that.phone,_that.email,_that.role,_that.businessUnits,_that.reportingToName,_that.reportingToCode,_that.reportingToRole);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String employeeId,  String empCode,  String name,  String phone,  String? email,  UserRole role,  List<BuRef> businessUnits,  String? reportingToName,  String? reportingToCode,  UserRole? reportingToRole)?  $default,) {final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that.id,_that.employeeId,_that.empCode,_that.name,_that.phone,_that.email,_that.role,_that.businessUnits,_that.reportingToName,_that.reportingToCode,_that.reportingToRole);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentUser extends CurrentUser {
  const _CurrentUser({required this.id, required this.employeeId, required this.empCode, required this.name, required this.phone, this.email, required this.role,  List<BuRef> businessUnits = const <BuRef>[], this.reportingToName, this.reportingToCode, this.reportingToRole}): _businessUnits = businessUnits,super._();
  

@override final  String id;
@override final  String employeeId;
@override final  String empCode;
@override final  String name;
@override final  String phone;
@override final  String? email;
@override final  UserRole role;
 final  List<BuRef> _businessUnits;
@override@JsonKey() List<BuRef> get businessUnits {
  if (_businessUnits is EqualUnmodifiableListView) return _businessUnits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_businessUnits);
}

@override final  String? reportingToName;
@override final  String? reportingToCode;
@override final  UserRole? reportingToRole;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentUserCopyWith<_CurrentUser> get copyWith => __$CurrentUserCopyWithImpl<_CurrentUser>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentUser&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.empCode, empCode) || other.empCode == empCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.businessUnits, _businessUnits)&&(identical(other.reportingToName, reportingToName) || other.reportingToName == reportingToName)&&(identical(other.reportingToCode, reportingToCode) || other.reportingToCode == reportingToCode)&&(identical(other.reportingToRole, reportingToRole) || other.reportingToRole == reportingToRole));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,employeeId,empCode,name,phone,email,role,const DeepCollectionEquality().hash(_businessUnits),reportingToName,reportingToCode,reportingToRole);
}

@override
String toString() {
    return 'CurrentUser(id: $id, employeeId: $employeeId, empCode: $empCode, name: $name, phone: $phone, email: $email, role: $role, businessUnits: $businessUnits, reportingToName: $reportingToName, reportingToCode: $reportingToCode, reportingToRole: $reportingToRole)';
}


}

/// @nodoc
abstract mixin class _$CurrentUserCopyWith<$Res> implements $CurrentUserCopyWith<$Res> {
  factory _$CurrentUserCopyWith(_CurrentUser value, $Res Function(_CurrentUser) _then) = __$CurrentUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String employeeId, String empCode, String name, String phone, String? email, UserRole role, List<BuRef> businessUnits, String? reportingToName, String? reportingToCode, UserRole? reportingToRole
});




}
/// @nodoc
class __$CurrentUserCopyWithImpl<$Res>
    implements _$CurrentUserCopyWith<$Res> {
  __$CurrentUserCopyWithImpl(this._self, this._then);

  final _CurrentUser _self;
  final $Res Function(_CurrentUser) _then;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeId = null,Object? empCode = null,Object? name = null,Object? phone = null,Object? email = freezed,Object? role = null,Object? businessUnits = null,Object? reportingToName = freezed,Object? reportingToCode = freezed,Object? reportingToRole = freezed,}) {
  return _then(_CurrentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,empCode: null == empCode ? _self.empCode : empCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,businessUnits: null == businessUnits ? _self._businessUnits : businessUnits // ignore: cast_nullable_to_non_nullable
as List<BuRef>,reportingToName: freezed == reportingToName ? _self.reportingToName : reportingToName // ignore: cast_nullable_to_non_nullable
as String?,reportingToCode: freezed == reportingToCode ? _self.reportingToCode : reportingToCode // ignore: cast_nullable_to_non_nullable
as String?,reportingToRole: freezed == reportingToRole ? _self.reportingToRole : reportingToRole // ignore: cast_nullable_to_non_nullable
as UserRole?,
  ));
}


}

// dart format on
