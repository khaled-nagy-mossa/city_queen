import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softgrow/module/fonts/cubit/cubit.dart';
import 'package:softgrow/module/fonts/cubit/states.dart';

/// Show all google fonts to choose one of them
/// to be the main font style in the application
class FontsView extends StatelessWidget {
  /// Initializes [key] for subclasses.
  const FontsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FontsCubit>(
      create: (context) => FontsCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<FontsCubit, FontsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = FontsCubit.get(context);
              return Scaffold(
                appBar: AppBar(title: Text('Fonts', style: cubit.font)),
                body: ListView.separated(
                  itemCount: cubit.fonts.length,
                  itemBuilder: (context, index) {
                    final font = cubit.fonts[index];
                    return ListTile(
                      title: Text(
                        font,
                        style: GoogleFonts.getFont(font),
                      ),
                      onTap: () {
                        cubit.selectedFonts = font;
                      },
                    );
                  },
                  separatorBuilder: (context, state) {
                    return const Divider();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
