import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peptide_tracker_app/src/features/peptides/data/datasources/peptides_local_data_source.dart';
import 'package:peptide_tracker_app/src/features/peptides/data/repositories/peptides_repository_impl.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/repositories/peptides_repository.dart';
import 'package:peptide_tracker_app/src/features/peptides/presentation/cubit/peptides_cubit.dart';
import 'package:peptide_tracker_app/src/features/peptides/presentation/view/peptides_page.dart';

/// Root application widget.
class App extends StatelessWidget {
  /// Creates the application shell.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PeptidesRepository>(
      create: (_) => const PeptidesRepositoryImpl(
        dataSource: PeptidesLocalDataSource(),
      ),
      child: BlocProvider(
        create: (context) => PeptidesCubit(
          repository: context.read<PeptidesRepository>(),
        )..load(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Peptide Tracker',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2E5BFF),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF0B1020),
            useMaterial3: true,
          ),
          home: const PeptidesPage(),
        ),
      ),
    );
  }
}
