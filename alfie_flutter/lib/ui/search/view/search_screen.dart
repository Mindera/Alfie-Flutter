import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/ui/search/view/default_search_body.dart';
import 'package:alfie_flutter/ui/search/view/search_suggestions.dart';
import 'package:alfie_flutter/ui/search/view_model/search_view_model.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = useState<String>('');

    final recentSearches = ref.watch(searchViewModelProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            titleSpacing: 0,
            elevation: 0,
            surfaceTintColor: AppColors.transparent,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.small,
                vertical: Spacing.extraExtraSmall,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.safePop(),
                    icon: Icon(AppIcons.back),
                  ),
                  Expanded(
                    child: Search(
                      onChanged: (value) => searchQuery.value = value,
                      autofocus: true,
                      onSubmitted: (value) {
                        ref
                            .read(searchViewModelProvider.notifier)
                            .submitSearch(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.all(Spacing.small),
            sliver: SliverToBoxAdapter(
              child: searchQuery.value.isEmpty
                  ? DefaultSearchBody(recentSearches: recentSearches)
                  : SearchSuggestions(),
            ),
          ),
        ],
      ),
    );
  }
}
