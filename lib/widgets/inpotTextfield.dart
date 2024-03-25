import 'package:flutter/material.dart';

class CostumTextFormFiled extends StatelessWidget {
  final TextEditingController? contol;
  final String? hintText;
  final bool? hid;
  final  hidIcon;
  final VoidCallback? press;
  final void Function(String)? onChanged;
   CostumTextFormFiled({
    this.hid,
    this.contol,
    this.hintText,
    this.hidIcon,
     this.press,
     this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 3,
        child: TextFormField(
          onChanged:  this.onChanged!,
            obscureText: this.hid!,
            controller: this.contol!,
            decoration: InputDecoration(
              hintText: this.hintText!,



              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 4, 41, .8),
                    width: 1.5
                ),),
              suffixIcon: IconButton(onPressed: this.press!,icon: this.hidIcon!,),
              contentPadding: EdgeInsets.only(left: 20 , top: 30),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                      color:  Color.fromRGBO(0, 4, 41, .8)
                  ),
              ),

            )
        ),
      ),
    );
  }
}


class CostumNonTextFormFiled extends StatelessWidget {
  final TextEditingController? contol;
  final String? hintText;
  final void Function(String)? onChanged;

  CostumNonTextFormFiled({
    this.contol,
    this.hintText,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(

        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 3,
        child: TextFormField(
          onChanged:  this.onChanged,
            controller: this.contol,
            decoration: InputDecoration(
              hintText: this.hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 4, 41, .8),
                    width: 1.5
                ),),
              contentPadding: EdgeInsets.only(left: 20 , top: 30),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                      color:  Color.fromRGBO(0, 4, 41, .8)
                  )
              ),

            )
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  final TextEditingController? contol;
  final String? hintText;
  final void Function(String)? onChanged;

  EditProfileTextField({
    this.contol,
    this.hintText,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 10 , bottom: 15),
      child: Card(
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 3,
          child: TextFormField(
            onChanged:  this.onChanged,
              controller: this.contol,
              decoration: InputDecoration(
                hintText: this.hintText,
               
                contentPadding: EdgeInsets.only(left: 10 , top: 10)
    
              )
          ),
        ),
    );
  }
}







