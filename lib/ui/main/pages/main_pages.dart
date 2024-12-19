import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../providers/main/index_nav_provider.dart';
import '../../favorite/pages/favorite_page.dart';
import '../../home/pages/home_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../search/pages/search_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the theme (light or dark mode)
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = isDarkMode ? Colors.grey[400] : Colors.grey[800];
    final selectedColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (_, indexNavProvider, __) {
          switch (indexNavProvider.indexBottomNavBar) {
            case 0:
              return const HomePage();
            case 1:
              return const SearchPage();
            case 2:
              return const FavoritePage();
            case 3:
              return const ProfilePage();
            default:
              return const HomePage();
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        destinations: [
          NavigationDestination(
            label: 'Home',
            selectedIcon: SvgPicture.asset(
              'assets/icons/ic_home_selected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                selectedColor,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(
              'assets/icons/ic_home_unselected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                unselectedColor!,
                BlendMode.srcIn,
              ),
            ),
          ),
          NavigationDestination(
            label: 'Search',
            selectedIcon: SvgPicture.asset(
              'assets/icons/ic_search_selected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                selectedColor,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(
              'assets/icons/ic_search_unselected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                unselectedColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          NavigationDestination(
            label: 'Favorite',
            selectedIcon: SvgPicture.asset(
              'assets/icons/ic_favorite_selected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                selectedColor,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(
              'assets/icons/ic_favorite_unselected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                unselectedColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          NavigationDestination(
            label: 'Profile',
            selectedIcon: SvgPicture.asset(
              'assets/icons/ic_profile_selected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                selectedColor,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(
              'assets/icons/ic_profile_unselected.svg',
              width: 18.0,
              colorFilter: ColorFilter.mode(
                unselectedColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
        onDestinationSelected: (index) {
          context.read<IndexNavProvider>().indexBottomNavBar = index;
        },
      ),
    );
  }
}
