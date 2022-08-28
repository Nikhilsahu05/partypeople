import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';
import 'google_places_autocomplete_view.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'map',
        home: GooglePlacesAutocompleteView(),
      ),
    );
  }
}
