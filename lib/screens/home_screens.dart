import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/custom_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: MoviesSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //tarjetas de peliculas
              CustomCardSwiper(movies: moviesProvider.onDisplayMovie),

              // slider de peliculas
              MovieSliderwidget(
                movie: moviesProvider.popularMovies,
                title: 'Populares',
                onNextPage: () => moviesProvider.getPopularMovies(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
