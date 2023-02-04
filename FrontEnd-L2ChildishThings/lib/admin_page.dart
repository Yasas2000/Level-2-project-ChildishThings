  // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, prefer_if_null_operators, avoid_unnecessary_containers

  import 'package:flutter/material.dart';
  import 'package:frontend/services/user_api_service.dart';
  import 'package:frontend/models/user.dart';
  import 'package:flutter_side_menu/flutter_side_menu.dart';
  class Admin extends StatefulWidget {

    @override
    State<Admin> createState() => _AdminState();
  }

  class _AdminState extends State<Admin> {
    
    UserApiService apiService = UserApiService();
    List<User> ? userList;

    @override
    void initState() {
      apiService.fetchUsers();
      super.initState();
      
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
            body: Row(
              children: [
                SideMenu( 
                  builder: (data) => SideMenuData(
                    
                    header: const Text('Menu'),
                    
                    items: [
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Dashboard',
                        icon: const Icon(Icons.dashboard,color: Colors.orange,),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Home',
                        icon: const Icon(Icons.home,color: Colors.orange),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Photo Gallery',
                        icon: const Icon(Icons.photo_album,color: Colors.orange),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Pricing',
                        icon: const Icon(Icons.calculate_rounded,color: Colors.orange),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Notifications',
                        icon: const Icon(Icons.notifications_active,color: Colors.orange),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Settings',
                        icon: const Icon(Icons.settings,color: Colors.orange),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                      SideMenuItemDataTile(
                        isSelected: true,
                        onTap: () {},
                        title: 'Logout',
                        icon: const Icon(Icons.logout_rounded,color: Colors.orange),
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white
                      ),
                    ],
                    
                  ),
                ),
                Expanded(
                  child: Container(
                    
                    color: Colors.white,                
                      child: FutureBuilder<List<User>>(
                            future: apiService.fetchUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<User>? users = snapshot.data;
                                return ListView.builder(
                                  itemCount: users!.length,
                                  itemBuilder: (context, index) {
                                    User user = users[index];
                                    return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 140,
                                        child: Card(
                                            child: Column(
                                            children: [
                                              Text(user.fullName != null ? user.fullName : "Unknown"),
                                              SizedBox(height: 10,),
                                              Text(user.email != null ? user.email : "Unknown"),
                                              SizedBox(height: 10,),
                                              Text(user.phoneNumber != null ? user.phoneNumber : "Unknown"),
                                              SizedBox(height: 10,),
                                              Text(user.role != null ? user.role : "Unknown"),
                                            ],
                                          ),
                                      ),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                  ),
                ),
                SideMenu(
                  position: SideMenuPosition.right,
                  builder: (data) => const SideMenuData(
                    customChild: Text('Custom view'),
                  ),
                ),
              ],
            ),
          );
    }
  }