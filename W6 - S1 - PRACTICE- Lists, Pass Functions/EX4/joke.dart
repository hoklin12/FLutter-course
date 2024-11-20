
class joke {
  final String title;
  final String description;

  joke({required this.title, required this.description});
}

final List<joke> jokes = List.generate(20,
        (index) => joke
      (title: "Joke ${index+1}",
        description: "Joke description ${index+1}"));