import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/components/auth_wrapper.dart';
import 'package:my_app/cubit/balance/cubit/balance_cubit.dart';
import 'package:my_app/cubit/counter_cubit.dart';
import 'package:my_app/cubit/cubit/auth_cubit.dart';
import 'package:my_app/dto/routes/balance_screen.dart';
import 'package:my_app/dto/routes/spending_screen.dart';
import 'package:my_app/screens/counter_screen.dart';
import 'package:my_app/screens/cust_screen.dart';
import 'package:my_app/screens/datas_screen.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/cubit/cubit/data_login_cubit.dart';
import 'package:my_app/screens/register_screen.dart';
// import 'package:my_app/screens/news_feeds.dart'; // Import NewsFeed screen
import 'package:my_app/screens/review_screen.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/sec_screen.dart';
import 'package:my_app/screens/welcome_screen.dart';
import 'package:my_app/screens/login_user_screen.dart';
import 'package:my_app/screens/admin_screen.dart';
import 'package:my_app/screens/teknisi_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
        BlocProvider<BalanceCubit>(create: (context) => BalanceCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<DataLoginCubit>(create: (context) => DataLoginCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(), // Set LoginScreen as the initial screen
        routes: {
          '/home': (context) => const MyHomePage(title: 'Home Screen'),
          // '/news': (context) => const NewsFeed(),
          '/datas': (context) => const DatasScreen(),
          '/cust': (context) => const CustomerServiceScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/counter': (context) => const CounterScreen(),
          '/spendings':(context) => 
            const AuthWrapper(child: SpendingScreen()),
          '/balances':(context) => 
            const AuthWrapper(child: BalanceScreen()),
          '/login':(context) => const LoginScreen(),
          '/adminscreen': (context) => const AdminScreen(title: 'Service Laptopmu!'),
          '/teknisiscreen': (context) => const HomeTeknisiScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  

  final List<Widget> _screens = [
    const HomeScreen(),
    const ReviewScreen(),
    const HistoryScreen(selectedLocation: ''),
    const SecondScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Review',
    'History',
  ]; // List of titles corresponding to each screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Nunik Astari'),
              accountEmail: Text('nunikastari@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/nunik.jpg'),
                radius: 20,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.data_array),
              title: const Text('datas'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed('/datas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Cust'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed('/cust');
              },
            ),
            ListTile(
              leading: const Icon(Icons.handshake),
              title: const Text('Welcome'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed('/welcome');
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Counter'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed('/counter');
              },
            ),
            ListTile(
              leading: const Icon(Icons.handshake),
              title: const Text('spending'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed('/spendings');
              },
            ),
            // 
            ListTile(
                leading: const Icon(Icons.cabin),
                title: const Text('counter'),
                onTap: () {
                  Navigator.of(context).pop(); // Close drawer
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BalanceScreen(), 
                    ),
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.back_hand),
              title: const Text('keluar'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed('/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Rekomendasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
