import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/models.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:flutter_instagram/widgets/user_profile_image.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ProfileScreen.routeName,
            arguments: ProfileScreenArgs(
              userId: post.author.id,
            ),
          ),
          child: Row(
            children: [
              UserProfileImage(
                radius: 18.0,
                profileImageUrl: post.author.profileImageUrl,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  post.author.username,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
