import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter_instagram/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key key,
    this.isCurrentUser,
    this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              EditProfileScreen.routeName,
              arguments: EditProfileScreenArgs(context: context),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
              textStyle: TextStyle(
                fontSize: 16.0,
              ),
            ),
            child: Text('Edit Profile'),
          )
        : TextButton(
            onPressed: () => isFollowing
                ? context.read<ProfileBloc>().add(ProfileUnfollowUser())
                : context.read<ProfileBloc>().add(ProfileFollowUser()),
            style: TextButton.styleFrom(
              backgroundColor: isFollowing
                  ? Colors.grey[300]
                  : Theme.of(context).primaryColor,
              primary: isFollowing ? Colors.black : Colors.white,
              textStyle: TextStyle(
                fontSize: 16.0,
              ),
            ),
            child: Text(isFollowing ? 'Unfollow' : 'Follow'),
          );
  }
}
