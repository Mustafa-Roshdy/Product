import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:product/Provider/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  // final ApiClient _apiClient = ApiClient();
  @override
  Widget build(BuildContext context) {

    return Consumer<UserProvider>(
      builder: (context,userProvider,child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   title: Text("Login", style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,color: Colors.pink),),
          // ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
        
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_red_eye, size: 100, color: Colors.pink),
                        Gap(10),
                        Icon(Icons.remove_red_eye, size: 100, color: Colors.pink),
                      ],
                    ),
                    Gap(40),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.pink,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              FormBuilder(
                key:userProvider.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'email',
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          errorMaxLines: 2,
                          labelText: 'Enter Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required()
                          // FormBuilderValidators.email(),
                        ]),
                      ),
                      Gap(20),
                      FormBuilderTextField(
                        name: 'pass',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          errorMaxLines: 2,
                          errorStyle: TextStyle(fontSize: 11),
                          labelText: 'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          // FormBuilderValidators.password(),
                        ]),
                      ),
                      Gap(100),
        
                      MaterialButton(
                        // color: Theme.of(context).colorScheme.secondary,
                        color: Colors.pink,
        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 100,
                        ),
        
                        onPressed: () {
                          // Validate and save the form values
                          // _formKey.currentState?.saveAndValidate();
                          // debugPrint(_formKey.currentState?.value.toString());
                          userProvider.login(context);
                          // if (_formKey.currentState!.isValid) {
                          //   authData(
                          //     _formKey.currentState?.value["email"],
                          //     _formKey.currentState?.value["pass"],
                          //   );
                          // }
                        },
                        child: const Text(
                          'Login Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have any Account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Gap(5),
                  InkWell(
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Colors.pink,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/register");
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
