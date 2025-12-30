import 'package:flutter/material.dart';
import 'package:sizekit/sizekit.dart';

void main() {
  runApp(
    const SizeKit(
      // The dimensions of the frame in your Figma file
      designSize: Size(375, 812), // Default Figma Mobile Frame
      breakpoints: Breakpoints(
        mobile: 480,
        tablet: 768,
        desktop: 1024,
      ), // Default breakpoints
      child: SizeKitExampleApp(),
    ),
  );
}

class SizeKitExampleApp extends StatelessWidget {
  const SizeKitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SizeKit Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    BasicUsageExample(),
    ResponsiveLayoutExample(),
    SpacingExample(),
    PercentageExample(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SizeKit Examples',
          style: TextStyle(fontSize: 20.sp(context)),
        ),
        centerTitle: true,
      ),
      body: ResponsiveLayout(
        mobile: Column(
          children: [
            Expanded(child: _pages[_selectedIndex]),
            _buildBottomNavigationBar(),
          ],
        ),
        desktop: Row(
          children: [
            _buildNavigationRail(),
            const VerticalDivider(width: 1),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Basic'),
        BottomNavigationBarItem(icon: Icon(Icons.view_quilt), label: 'Layout'),
        BottomNavigationBarItem(icon: Icon(Icons.space_bar), label: 'Spacing'),
        BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Percent'),
      ],
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.code), label: Text('Basic')),
        NavigationRailDestination(
            icon: Icon(Icons.view_quilt), label: Text('Layout')),
        NavigationRailDestination(
            icon: Icon(Icons.space_bar), label: Text('Spacing')),
        NavigationRailDestination(
            icon: Icon(Icons.percent), label: Text('Percent')),
      ],
    );
  }
}

/// Example 1: Basic Usage
class BasicUsageExample extends StatelessWidget {
  const BasicUsageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: 16.w(context).all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Usage',
            style: TextStyle(
              fontSize: 24.sp(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          20.vSpace,
          _buildExampleCard(
            context,
            title: '.w() - Scale Width',
            description: 'Maps Figma width pixel to current screen width',
            child: Container(
              width: 200.w(context),
              height: 100.h(context),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.r(context)),
              ),
              child: Center(
                child: Text(
                  '200px in Figma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp(context),
                  ),
                ),
              ),
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: '.h() - Scale Height',
            description: 'Maps Figma height pixel to current screen height',
            child: Container(
              width: 100.w(context),
              height: 150.h(context),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.r(context)),
              ),
              child: Center(
                child: Text(
                  '150px in Figma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp(context),
                  ),
                ),
              ),
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: '.sp() - Smart Font Size',
            description: 'Scales font size with clamp (0.8x - 1.4x)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Font size 14.sp(context)',
                  style: TextStyle(fontSize: 14.sp(context)),
                ),
                8.vSpace,
                Text(
                  'Font size 18.sp(context)',
                  style: TextStyle(fontSize: 18.sp(context)),
                ),
                8.vSpace,
                Text(
                  'Font size 24.sp(context)',
                  style: TextStyle(
                    fontSize: 24.sp(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: '.r() - Radius Scale',
            description: 'Scales border radius (alias for .w())',
            child: Row(
              children: [
                Container(
                  width: 60.w(context),
                  height: 60.w(context),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r(context)),
                  ),
                ),
                16.hSpace,
                Container(
                  width: 60.w(context),
                  height: 60.w(context),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16.r(context)),
                  ),
                ),
                16.hSpace,
                Container(
                  width: 60.w(context),
                  height: 60.w(context),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(24.r(context)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: 16.w(context).all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.vSpace,
            Text(
              description,
              style: TextStyle(
                fontSize: 14.sp(context),
                color: Colors.grey[600],
              ),
            ),
            16.vSpace,
            child,
          ],
        ),
      ),
    );
  }
}

/// Example 2: Responsive Layout
class ResponsiveLayoutExample extends StatelessWidget {
  const ResponsiveLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: 16.w(context).all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Responsive Layout',
            style: TextStyle(
              fontSize: 24.sp(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          20.vSpace,
          _buildInfoCard(
            context,
            'Breakpoint Detection',
            [
              'Is Mobile: ${context.isMobile}',
              'Is Tablet: ${context.isTablet}',
              'Is Desktop: ${context.isDesktop}',
              'Screen Width: ${context.screenWidth.toStringAsFixed(0)}px',
              'Screen Height: ${context.screenHeight.toStringAsFixed(0)}px',
            ],
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: 'ResponsiveLayout Widget',
            description: 'Switch layouts based on breakpoints',
            child: ResponsiveLayout(
              mobile: Container(
                padding: 16.w(context).all,
                color: Colors.blue.withValues(alpha: 0.2),
                child: Column(
                  children: [
                    Text('Mobile Layout',
                        style: TextStyle(fontSize: 16.sp(context))),
                    8.vSpace,
                    Text('Column layout for mobile',
                        style: TextStyle(fontSize: 14.sp(context))),
                  ],
                ),
              ),
              tablet: Container(
                padding: 24.w(context).all,
                color: Colors.green.withValues(alpha: 0.2),
                child: Column(
                  children: [
                    Text('Tablet Layout',
                        style: TextStyle(fontSize: 18.sp(context))),
                    8.vSpace,
                    Text('Optimized for tablets',
                        style: TextStyle(fontSize: 14.sp(context))),
                  ],
                ),
              ),
              desktop: Container(
                padding: 32.w(context).all,
                color: Colors.purple.withValues(alpha: 0.2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Desktop Layout',
                          style: TextStyle(fontSize: 20.sp(context))),
                    ),
                    16.hSpace,
                    Text('Row layout for desktop',
                        style: TextStyle(fontSize: 14.sp(context))),
                  ],
                ),
              ),
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: 'Conditional Rendering',
            description: 'Use context extensions for conditional widgets',
            child: context.isMobile
                ? Container(
                    padding: 16.w(context).all,
                    color: Colors.red.withValues(alpha: 0.2),
                    child: Text('Mobile View',
                        style: TextStyle(fontSize: 16.sp(context))),
                  )
                : Container(
                    padding: 16.w(context).all,
                    color: Colors.blue.withValues(alpha: 0.2),
                    child: Text('Desktop View',
                        style: TextStyle(fontSize: 16.sp(context))),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String title, List<String> items) {
    return Card(
      child: Padding(
        padding: 16.w(context).all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            12.vSpace,
            ...items.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h(context)),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 6, color: Colors.blue),
                      8.hSpace,
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 14.sp(context)),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: 16.w(context).all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.vSpace,
            Text(
              description,
              style: TextStyle(
                fontSize: 14.sp(context),
                color: Colors.grey[600],
              ),
            ),
            16.vSpace,
            child,
          ],
        ),
      ),
    );
  }
}

/// Example 3: Spacing
class SpacingExample extends StatelessWidget {
  const SpacingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: 16.w(context).all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spacing & Padding',
            style: TextStyle(
              fontSize: 24.sp(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          20.vSpace,
          _buildExampleCard(
            context,
            title: '.vSpace & .hSpace',
            description: 'Quick SizedBox widgets for spacing',
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 50.w(context),
                        height: 50.w(context),
                        color: Colors.red),
                    20.hSpace,
                    Container(
                        width: 50.w(context),
                        height: 50.w(context),
                        color: Colors.green),
                  ],
                ),
                20.vSpace,
                Row(
                  children: [
                    Container(
                        width: 50.w(context),
                        height: 50.w(context),
                        color: Colors.blue),
                    30.hSpace,
                    Container(
                        width: 50.w(context),
                        height: 50.w(context),
                        color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: 'Padding Extensions',
            description: 'Quick EdgeInsets creation',
            child: Column(
              children: [
                Container(
                  padding: 16.w(context).all,
                  color: Colors.blue.withValues(alpha: 0.2),
                  child: Text('16.all padding',
                      style: TextStyle(fontSize: 14.sp(context))),
                ),
                8.vSpace,
                Container(
                  padding: 16.w(context).horizontal,
                  color: Colors.green.withValues(alpha: 0.2),
                  child: Text('16.horizontal padding',
                      style: TextStyle(fontSize: 14.sp(context))),
                ),
                8.vSpace,
                Container(
                  padding: 16.w(context).vertical,
                  color: Colors.orange.withValues(alpha: 0.2),
                  child: Text('16.vertical padding',
                      style: TextStyle(fontSize: 14.sp(context))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: 16.w(context).all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.vSpace,
            Text(
              description,
              style: TextStyle(
                fontSize: 14.sp(context),
                color: Colors.grey[600],
              ),
            ),
            16.vSpace,
            child,
          ],
        ),
      ),
    );
  }
}

/// Example 4: Percentage Scaling
class PercentageExample extends StatelessWidget {
  const PercentageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: 16.w(context).all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Percentage Scaling',
            style: TextStyle(
              fontSize: 24.sp(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          20.vSpace,
          _buildExampleCard(
            context,
            title: '.sw() - Screen Width Percentage',
            description: '0.5.sw(context) = 50% of screen width',
            child: Container(
              width: 0.5.sw(context),
              height: 100.h(context),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.pink],
                ),
                borderRadius: BorderRadius.circular(8.r(context)),
              ),
              child: Center(
                child: Text(
                  '50% Width',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp(context),
                  ),
                ),
              ),
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: '.sh() - Screen Height Percentage',
            description: '0.2.sh(context) = 20% of screen height',
            child: Container(
              width: double.infinity,
              height: 0.2.sh(context),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.cyan],
                ),
                borderRadius: BorderRadius.circular(8.r(context)),
              ),
              child: Center(
                child: Text(
                  '20% Height',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp(context),
                  ),
                ),
              ),
            ),
          ),
          16.vSpace,
          _buildExampleCard(
            context,
            title: 'Combined Usage',
            description: 'Using multiple extensions together',
            child: Container(
              width: 0.7.sw(context),
              height: 0.15.sh(context),
              padding: 16.w(context).all,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.blue, Colors.cyan],
                ),
                borderRadius: BorderRadius.circular(12.r(context)),
              ),
              child: Center(
                child: Text(
                  '70% width × 15% height',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: 16.w(context).all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.vSpace,
            Text(
              description,
              style: TextStyle(
                fontSize: 14.sp(context),
                color: Colors.grey[600],
              ),
            ),
            16.vSpace,
            child,
          ],
        ),
      ),
    );
  }
}
