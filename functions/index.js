const functions = require("firebase-functions");
const admin = require("firebase-adimn");

exports.unFollowUser = functions.firestore
    .document('/followers/{userId}/userFollowers/{followerId}')
    .onCreate(async (_, context) => {
        const userId = context.params.userId;
        const followerId = context.params.followerId;

        const followedUserRef = admin.firestore().collection('users').doc(userId);
        const followedUserDoc = await followedUserRef.get();
        if (followedUserDoc.get('followers') !== undefined) {
            followedUserRef.update({
                followers: followedUserDoc.get('followers') + 1
            });
        } else {
            followedUserRef.update({
                followers: 1
            });
        }

        const userRef = admin.firestore().collection('users').doc(followerId);
        const userDoc = await userRef.get();
        if (userDoc.get('following') !== undefined) {
            userRef.update({
                following: userDoc.get('following') + 1
            });
        } else {
            userRef.update({
                following: 1
            });
        }

        const followedUserPostsRef = admin.firestore()
            .collection('posts')
            .where('author', '==', followedUserRef);
        const userFeedRef = admin.firestore()
            .collection('feeds')
            .doc(followerId)
            .collection('userFeeds');
        const followedUserPostsSnapshot = await followedUserPostsRef.get();
        followedUserPostsSnapshot.forEach((doc) => {
            if (doc.exists) {
                userFeedRef.doc(doc.id).set(doc.data());
            }
        });
    });

exports.onUnfollowUser = functions.firestore
    .document('/followers/{userId}/userFollowers/followerId')
    .onCreate(async (_, context) => {
        const userId = context.params.userId;
        const followerId = context.params.followerId;

        const followedUserRef = admin.firestore().collection('users').doc(userId);
        const followedUserDoc = await followedUserRef.get();
        if (followedUserDoc.get('followers') !== undefined) {
            followedUserRef.update({
                followers: followedUserDoc.get('followers') - 1
            });
        } else {
            followedUserRef.update({
                followers: 0
            });
        }

        const userRef = admin.firestore().collection('users').doc(followerId);
        const userDoc = await userRef.get();
        if (userDoc.get('following') !== undefined) {
            userRef.update({
                following: userDoc.get('following') - 1
            });
        } else {
            userRef.update({
                following: 0
            });
        }

        const userFeedRef = admin
            .firestore()
            .collection('feeds')
            .doc(followerId)
            .collection('userFeeds')
            .where('author', '==', followedUserRef);
        const userPostsSnapshot = await userFeedRef.get();
        userPostsSnapshot.forEach((doc) => {
            if (doc.exists) {
                doc.ref.delete();
            }
        });
    });