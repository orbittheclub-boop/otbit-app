/// Payload for creating/editing a board post.
class BoardPostInput {
  const BoardPostInput({
    required this.category,
    required this.title,
    required this.body,
  });

  final String category; // free|question|tip|review
  final String title;
  final String body;
}
