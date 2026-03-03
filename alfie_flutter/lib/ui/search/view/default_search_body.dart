import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/ui/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultSearchBody extends ConsumerWidget {
  const DefaultSearchBody({
    super.key,
    required this.recentSearches,
    this.onSearchItemTapped,
  });

  final List<SearchItem> recentSearches;
  final void Function(String query)? onSearchItemTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: Spacing.extraLarge,
      children: [
        if (recentSearches.isNotEmpty)
          Column(
            spacing: Spacing.extraSmall,
            children: [
              SectionHeader(
                title: "Your Recent Searches",
                linkText: "Clear",

                onLinkPressed: () {
                  ref.read(searchViewModelProvider.notifier).clearHistory();
                },
              ),

              ...recentSearches.map(
                (item) => GestureDetector(
                  onTap: () => onSearchItemTapped?.call(item.query),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Spacing.extraExtraSmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(item.query)),
                        AppButton.tertiary(
                          onPressed: () {
                            ref
                                .read(searchViewModelProvider.notifier)
                                .removeSearch(item.query);
                          },
                          leading: AppIcons.clear,
                          size: ButtonSize.small,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        SectionHeader(title: "Popular Items"),
        // TODO: Popular Items
      ],
    );
  }
}
