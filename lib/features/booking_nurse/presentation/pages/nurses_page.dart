import 'package:cure/core/di/injection.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:cure/features/booking_nurse/presentation/cubits/nurses_cubit.dart';
import 'package:cure/features/booking_nurse/presentation/cubits/nurses_state.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/nurse_card.dart';
import 'nurse_details_page.dart';

class NursesPage extends StatefulWidget {
  const NursesPage({super.key, required this.role});

  final String role;

  @override
  State<NursesPage> createState() => _NursesPageState();
}

class _NursesPageState extends State<NursesPage> {
  final _scrollController = ScrollController();
  late final NursesCubit _nursesCubit;

  @override
  void initState() {
    super.initState();
    _nursesCubit = di.createNursesCubit()..loadFirstPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _nursesCubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final isNearBottom = position.pixels >= position.maxScrollExtent - 220;
    if (!isNearBottom) return;

    _nursesCubit.loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return BlocProvider.value(
      value: _nursesCubit,
      child: Scaffold(
        backgroundColor: colors.gradientEnd,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.role == 'nurse'
                ? S.of(context).checkNurses
                : S.of(context).bookAnurse,
            style: TextStyle(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<NursesCubit, NursesState>(
          builder: (context, state) {
            if (state.status == NursesStatus.loading && state.nurses.isEmpty) {
              return const Center(child: LoadingWidget());
            }

            if (state.status == NursesStatus.error && state.nurses.isEmpty) {
              return _MessageView(
                message: state.errorMessage ?? 'Could not load nurses',
                buttonText: 'Try again',
                onPressed: () => context.read<NursesCubit>().loadFirstPage(),
              );
            }

            if (state.nurses.isEmpty) {
              return _MessageView(
                message: 'No available nurses yet',
                buttonText: 'Refresh',
                onPressed: () => context.read<NursesCubit>().loadFirstPage(),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<NursesCubit>().loadFirstPage(),
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemBuilder: (context, index) {
                  if (index == state.nurses.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: LoadingWidget()),
                    );
                  }

                  final nurse = state.nurses[index];
                  return NurseCard(
                    nurse: nurse,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              NurseDetailsPage(nurse: nurse, role: widget.role),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemCount:
                    state.nurses.length +
                    (state.status == NursesStatus.loadingMore ? 1 : 0),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurfaceMuted,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: onPressed, child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}
