import 'package:flutter/material.dart';

class SearchPersonalPage extends StatefulWidget {
  const SearchPersonalPage({super.key});

  @override
  State<SearchPersonalPage> createState() => _SearchPersonalPageState();
}

class _SearchPersonalPageState extends State<SearchPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        flexibleSpace: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320,
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black), //<-- SEE HERE
                          ),
                          hintText: 'Enter a search term',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
