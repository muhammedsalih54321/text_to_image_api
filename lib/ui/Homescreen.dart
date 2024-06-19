

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_ai/Repository/Model/ai_model.dart';

import 'package:image_to_text_ai/bloc/Ai/ai_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Almodel ai;
  final controller = TextEditingController();
  String errorMessage = ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AiBloc, AiState>(
                builder: (context, state) {
                  if (state is Aiblocloading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Aiblocerror) {
                    return RefreshIndicator(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .9,
                          child: Center(child: Text('Oops something went wrong')),
                        ),
                      ),
                      onRefresh: () async {
                        return BlocProvider.of<AiBloc>(context)
                            .add(FetchaiEvent(text: 'text'));
                      },
                    );
                  } else if (state is Aiblocloaded) {
                    ai = BlocProvider.of<AiBloc>(context).aimodel;
                    return Container(
                      height: 500,
                      width: double.infinity,
                      color: Colors.black,
                      child: controller.text.isNotEmpty
                          ? Image.network(
                              ai.url.toString(),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                errorMessage.isEmpty
                                    ? 'Please enter a text to process.'
                                    : errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(72, 0, 0, 0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            errorMessage = ''; 
                            
                          });
                        },
                        controller: controller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    setState(() {
                      errorMessage = 'Please enter a text to process.'; // Set error message when empty
                    });
                  } else {
                    BlocProvider.of<AiBloc>(context)
                        .add(FetchaiEvent(text: controller.text));
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
