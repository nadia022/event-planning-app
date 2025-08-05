import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/home/event_item_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    if (eventListProvider.favoriteEventList.isEmpty) {
      eventListProvider.getFavouriteEvents();
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.008, horizontal: width * 0.016),
              child: TextFormField(
                decoration: InputDecoration(
                  hintStyle: AppStyles.mediumBlue16,
                  hintText: appLocalization.search_for_event,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primaryColorLight,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        width: 1, color: AppColors.primaryColorLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        width: 1, color: AppColors.primaryColorLight),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(width: 1, color: AppColors.red),
                  ),
                ),
              ),
            ),
            Expanded(
              child: eventListProvider.favoriteEventList.isEmpty
                  ? Center(
                      child: Text(
                        "No events Found",
                        style: AppStyles.mediumBlack16,
                      ),
                    )
                  : ListView.builder(
                      itemCount: eventListProvider.favoriteEventList.length,
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                            event: eventListProvider.favoriteEventList[index]);
                      }),
            )
          ],
        ),
      ),
    );
  }
}
