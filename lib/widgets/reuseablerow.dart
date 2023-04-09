import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ReuseableRow extends StatelessWidget {
  final String? title,value;
  const ReuseableRow({Key? key,
  required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:5,left: 2,right: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!,style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500
              ),),
              Text(value!,style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(height: 4,),
          Divider()
        ],
      ),

    );
  }
}
