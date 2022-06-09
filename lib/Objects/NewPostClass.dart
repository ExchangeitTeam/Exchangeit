class UserPost {
  String text;
  String image_url;
  String date;
  int likeCount;
  int commentCount;
  List<dynamic> comments;
  String postId;
  String owner = '';
  String owner_name = '';
  String location = "";

  UserPost(
      {required this.postId,
      required this.text,
      required this.image_url,
      required this.date,
      required this.likeCount,
      required this.commentCount,
      required this.comments,
      this.owner = '',
      this.owner_name = '',
      this.location = ""});

  @override
  String toString() =>
      'ID: $postId\nCaption: $text\nDate: $date\nLikes: $likeCount\nComments: $commentCount';
}
