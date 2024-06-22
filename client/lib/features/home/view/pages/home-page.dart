import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nightAngle/features/home/view/pages/library-page.dart';
import 'package:nightAngle/features/home/view/pages/search-page.dart';
import 'package:nightAngle/features/home/view/pages/songs-page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var selectedPage = 0;

  final pages = const [SongsPage(), SearchPage(), LibraryPage()];
  @override
  Widget build(BuildContext context) {
    final user = ref.read(currentUserNotifierProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            label: 'Home',
            activeIcon: Icon(
              IconlyBold.home,
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.search),
            label: 'Search',
            activeIcon: Icon(IconlyBold.search),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/library.svg',
                height: 24,
                theme: SvgTheme(currentColor: Colors.grey.shade600)),
            label: 'Library',
            activeIcon: SvgPicture.asset('assets/icons/library.svg',
                height: 24,
                theme: const SvgTheme(currentColor: Pallete.primary)),
          ),
        ],
        onTap: (value) => setState(() {
          selectedPage = value;
        }),
        currentIndex: selectedPage,
      ),
      body: pages[selectedPage],
    );
  }
}
