import 'package:flutflix/api/api.dart';
import 'package:flutflix/widgets/movieslider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/movie.dart';
import 'widgets/trendingslider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('FLUTFLIX'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trending Movies', style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 32,),
              // const TrendingSlider(),
              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(
                          child: Text(snapshot.error.toString())
                      );
                    }
                    else if(snapshot.hasData){
                      return TrendingSlider(snapshot: snapshot,);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32,),
              Text('Top-rated Movies', style: GoogleFonts.aBeeZee(fontSize: 25),),
              const SizedBox(height: 32,),
              // const MovieSlider(),
              SizedBox(
                child: FutureBuilder(
                  future: topRatedMovies,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(
                          child: Text(snapshot.error.toString())
                      );
                    }
                    else if(snapshot.hasData){
                      return MovieSlider(snapshot: snapshot,);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32,),
              Text('Upcoming Movies', style: GoogleFonts.aBeeZee(fontSize: 25),),
              const SizedBox(height: 32,),
              // const MovieSlider(),
              SizedBox(
                child: FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(
                          child: Text(snapshot.error.toString())
                      );
                    }
                    else if(snapshot.hasData){
                      return MovieSlider(snapshot: snapshot,);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

