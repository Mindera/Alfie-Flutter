import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = useState<String>('');

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
                  ? _buildDefaultSearchViews(context)
                  : _buildSuggestions(context, searchQuery.value),
            ),
          ),
        ],
      ),
    );
  }

  /// What shows when the user hasn't typed anything yet
  Widget _buildDefaultSearchViews(BuildContext context) {
    return Column(
      spacing: Spacing.extraLarge,
      children: [
        // --- Recent Searches Section ---
        Column(
          spacing: Spacing.extraSmall,
          children: [
            SectionHeader(title: "Your Recent Searches", linkText: "Clear"),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Spacing.extraExtraSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("recent search"),
                  AppButton.tertiary(
                    onPressed: () {},
                    leading: AppIcons.clear,
                    size: ButtonSize.small,
                  ),
                ],
              ),
            ),
          ],
        ),

        // --- Popular Items Section ---
        SectionHeader(title: "Popular Items"),
      ],
    );
  }

  /// What shows as the user is typing
  Widget _buildSuggestions(BuildContext context, String query) {
    return Column(
      children: [
        // ListTile(
        //   leading: const Icon(Icons.search),
        //   title: Text('Search for "$query"'),
        //   onTap: () {},
        // ),
      ],
    );
  }
}
