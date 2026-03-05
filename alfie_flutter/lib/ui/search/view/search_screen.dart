import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_view.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/search/view/default_search_body.dart';
import 'package:alfie_flutter/ui/search/view/search_suggestions.dart';
import 'package:alfie_flutter/ui/search/view_model/search_view_model.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// The primary search interface.
///
/// Manages the local text input state and coordinates with the
/// [searchViewModelProvider] to transition between three distinct visual states:
/// 1. Default (Empty input): Shows recent searches.
/// 2. Suggestions (Typing): Shows predictive search suggestions.
/// 3. Results (Submitted): Shows the [ProductListingView] for the active query.
class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localQuery = useState<String>('');

    final state = ref.watch(searchViewModelProvider);
    final searchController = useTextEditingController();

    void submitSearch(String query) {
      localQuery.value = query;
      ref.read(searchViewModelProvider.notifier).submitSearch(query);
      searchController.text = query;
    }

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
                  AppButton.tertiary(
                    onPressed: () => context.safePop(),
                    leading: AppIcons.back,
                  ),
                  Expanded(
                    child: Search(
                      controller: searchController,
                      onChanged: (value) => localQuery.value = value,
                      autofocus: true,
                      onSubmitted: submitSearch,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (localQuery.value == state.currentSearchQuery)
            ProductListingView(id: ProductListingId(query: localQuery.value))
          else
            SliverPadding(
              padding: EdgeInsetsGeometry.all(Spacing.small),
              sliver: SliverToBoxAdapter(
                child: localQuery.value.isEmpty
                    ? DefaultSearchBody(
                        recentSearches: state.recentSearches,
                        onSearchItemTapped: submitSearch,
                      )
                    : SearchSuggestions(),
              ),
            ),
        ],
      ),
    );
  }
}
