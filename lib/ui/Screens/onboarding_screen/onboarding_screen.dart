import 'package:evently_app/ui/auth/login_screen/login_screen.dart';
import 'package:evently_app/ui/Screens/onboarding_screen/page_view_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "oboardingScreen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var themProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.05,
                right: width * 0.05,
                bottom: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.eventlyHorizentalLogo,
                  height: height * 0.08,
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                    controller: pageController,
                    children: [
                      PageViewWidget(
                          image: AppAssets.pageView1,
                          label: AppLocalizations.of(context)!
                              .find_events_that_inspire_you,
                          text: AppLocalizations.of(context)!
                              .dive_into_a_world_of_events_crafted_to_fit_your_unique_interests_whether_you_are_into_live_music_art_workshops_professional_networking_or_simply_discovering_new_experiences_we_have_something_for_everyone_our_curated_recommendations_will_help_you_explore_connect_and_make_the_most_of_every_opportunity_around_you),
                      PageViewWidget(
                        image: themProvider.themeMode == ThemeMode.light
                            ? AppAssets.pageView2LightMode
                            : AppAssets.pageView2DarkMode,
                        label: AppLocalizations.of(context)!
                            .effortless_event_planning,
                        text: AppLocalizations.of(context)!
                            .take_the_hassle_out_of_organizing_events_with_our_all_in_one_planning_tools_from_setting_up_invites_and_managing_rsvps_to_scheduling_reminders_and_coordinating_details_we_have_got_you_covered_plan_with_ease_and_focus_on_what_matters_creating_an_unforgettable_experience_for_you_and_your_guests,
                      ),
                      PageViewWidget(
                          image: themProvider.themeMode == ThemeMode.light
                              ? AppAssets.pageView3LightMode
                              : AppAssets.pageView3DarkMode,
                          label: AppLocalizations.of(context)!
                              .connect_with_friends_share_moments,
                          text: AppLocalizations.of(context)!
                              .make_every_event_memorable_by_sharing_the_experience_with_others_our_platform_lets_you_invite_friends_keep_everyone_in_the_loop_and_celebrate_moments_together_capture_and_share_the_excitement_with_your_network_so_you_can_relive_the_highlights_and_cherish_the_memories),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (index != 0) {
                          pageController.jumpToPage(index - 1);
                        }
                      },
                      child: ForwardArrowWidget(Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColorLight,
                      )),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    SmoothPageIndicator(
                      axisDirection: Axis.horizontal,
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.primaryColorLight,
                        dotColor: Color(0xff707070),
                        dotHeight: 7,
                        dotWidth: 8,
                        spacing: 12,
                        radius: 27,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        if (index != 2) {
                          pageController.jumpToPage(index + 1);
                        } else {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        }
                      },
                      child: ForwardArrowWidget(Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColorLight,
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ForwardArrowWidget(Icon icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.primaryColorLight,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25)),
      child: icon,
    );
  }
}
