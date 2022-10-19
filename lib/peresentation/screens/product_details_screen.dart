import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwithfirebase/data/models/home_model.dart';

class ProductDetailsScreen extends StatefulWidget {
 final  ProductsModel model;

  const ProductDetailsScreen({Key? key,required this.model}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build( BuildContext context) {
    return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                backgroundColor: Colors.grey,
                flexibleSpace: FlexibleSpaceBar(

                  background: Image.network('${widget.model.image}', fit: BoxFit.cover,),
                ),

              ),
              SliverList(delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(

                    children: [
                      Text(
                        '${widget.model.name}',
                        style: TextStyle(
                           fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      Container(
                        width: double.infinity,
                          height: 1,
                          color: Colors.black,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        '${widget.model.description}'
                      ),

                    ],
                  ),
                )
              ]))
            ],
          ),
        );
     ;
  }
}
