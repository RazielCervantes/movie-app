import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';

class MovieSliderwidget extends StatefulWidget {
  final String? title;
  final List<Movie> movie;
  final Function onNextPage;
  const MovieSliderwidget(
      {Key? key, this.title, required this.movie, required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSliderwidget> createState() => _MovieSliderwidgetState();
}

class _MovieSliderwidgetState extends State<MovieSliderwidget> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.movie.length == 0) {
      return Container(
        width: double.infinity,
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: double.infinity,
      height: 300,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movie.length,
                itemBuilder: (BuildContext context, int index) {
                  final movies = widget.movie[index];
                  return _MoviePoster(
                    movie: movies,
                    heroId: '${widget.title}-$index-${widget.movie[index].id}',
                    // imageMovie: movies.fullPosterImg,
                    // nameMovie: movies.title,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  // final String imageMovie;
  // final String nameMovie;
  final Movie movie;
  final String heroId;
  const _MoviePoster({
    Key? key,
    // required this.imageMovie,
    // required this.nameMovie,
    required this.movie,
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 190,

      // color: Colors.green,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie),
          child: Hero(
            tag: heroId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
