import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/editable_stock_tile.dart';

class EditWatchlistPage extends StatelessWidget {
  const EditWatchlistPage({super.key});

  Future<bool> _confirmDiscard(BuildContext context) async {
    final isDirty = context.read<WatchlistBloc>().state.isDirty;
    if (!isDirty) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text(
          'You have unsaved changes to this watchlist.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final ok = await _confirmDiscard(context);
        if (!ok || !context.mounted) return;
        context.read<WatchlistBloc>().add(const WatchlistEditCancelled());
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          surfaceTintColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
            onPressed: () async {
              final ok = await _confirmDiscard(context);
              if (!ok || !context.mounted) return;
              context
                  .read<WatchlistBloc>()
                  .add(const WatchlistEditCancelled());
              Navigator.of(context).pop();
            },
          ),
          title: BlocBuilder<WatchlistBloc, WatchlistState>(
            buildWhen: (p, n) => p.draft?.name != n.draft?.name,
            builder: (context, state) => Text(
              'Edit ${state.draft?.name ?? ''}',
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (p, n) => p.draft != n.draft,
      builder: (context, state) {
        final draft = state.draft;
        if (draft == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            _NameField(name: draft.name),
            Expanded(
              child: ReorderableListView.builder(
                buildDefaultDragHandles: false,
                itemCount: draft.stocks.length,
                proxyDecorator: (child, index, animation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      final t = Curves.easeInOut.transform(animation.value);
                      return Material(
                        elevation: 6 * t,
                        color: AppColors.background,
                        shadowColor: Colors.black26,
                        child: child,
                      );
                    },
                  );
                },
                onReorderStart: (_) => HapticFeedback.mediumImpact(),
                onReorder: (oldIndex, newIndex) {
                  context.read<WatchlistBloc>().add(
                        WatchlistReorderRequested(
                          oldIndex: oldIndex,
                          newIndex: newIndex,
                        ),
                      );
                },
                itemBuilder: (context, i) {
                  final stock = draft.stocks[i];
                  return EditableStockTile(
                    key: ValueKey(stock.id),
                    stock: stock,
                    index: i,
                    onDelete: () {},
                  );
                },
              ),
            ),
            const _BottomBar(),
          ],
        );
      },
    );
  }
}

class _NameField extends StatefulWidget {
  const _NameField({required this.name});
  final String name;

  @override
  State<_NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  late final TextEditingController _controller;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
    _focus = FocusNode();
    
  }

  @override
  void didUpdateWidget(covariant _NameField old) {
    super.didUpdateWidget(old);
    if (!_focus.hasFocus && _controller.text != widget.name) {
      _controller.text = widget.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focus,
              textInputAction: TextInputAction.done,
             
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.secondaryText,
              size: 20,
            ),
            onPressed: () => _focus.requestFocus(),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppColors.primaryText),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                foregroundColor: AppColors.primaryText,
              ),
              child: const Text(
                'Edit other watchlists',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<WatchlistBloc, WatchlistState>(
              buildWhen: (p, n) => p.isDirty != n.isDirty,
              builder: (context, state) {
                final enabled = state.isDirty;
                return ElevatedButton(
                  onPressed: enabled
                      ? () {
                          context
                              .read<WatchlistBloc>()
                              .add(const WatchlistSaved());
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryText,
                    disabledBackgroundColor:
                        AppColors.primaryText.withOpacity(0.4),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white70,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Save Watchlist',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
