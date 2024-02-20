import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionary_voices/screens/dashboard.dart';
import 'package:visionary_voices/screens/signup_screen.dart';
import '../theme/theme.dart';
import '../widgets/custom_scaffold.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var auth=FirebaseAuth.instance;
  login(){
    auth.authStateChanges().listen((User? user)
    {
      if(user!=null && mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>new Singlefilepicker()), (Route <dynamic> route) => false);
      }
    }
    );
  }
  @override
  void initState() {
  login();
    super.initState();
  }
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
TextEditingController _email=TextEditingController();
TextEditingController _pwd=TextEditingController();

    return CustomScaffold(
    child: Column(
      children: [
        const Expanded(
          flex: 1,
            child: SizedBox(
              height: 10,
        )
        ),
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
            child: SingleChildScrollView(
              child: Form(
                key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                     const SizedBox(
                       height: 40.0,
                     ),
                     TextFormField(
                       controller: _email,
                       validator: (value){
                         if(value==null || value.isEmpty){
                           return 'Please Enter Email';
                         }
                         return null;
                       },
                       decoration: InputDecoration(
                         label: const Text("Email"),
                         hintText: 'Enter Email',
                         hintStyle: const TextStyle(
                           color: Colors.black,
                         ),
                         border: OutlineInputBorder(
                           borderSide: const BorderSide(
                             color: Colors.black12,
                           ),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderSide: const BorderSide(
                             color: Colors.black12,
                           ),
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
              
                     ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        controller: _pwd,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
              
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Text(
                              'Forget password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            if(_email.text.isEmpty || _pwd.text.isEmpty){
                              var snackBar = SnackBar(content: Text('Empty Field'),backgroundColor: Colors.red,);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                           else{
                              try {
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: _email.text.toString(),
                                    password: _pwd.text.toString()
                                );
                                // if(FirebaseAuth.instance.currentUser!=null){
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Singlefilepicker()),);
                                // }
                                //
                                // if(FirebaseAuth.instance.currentUser==null){
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //           content: Text('Create your account'),
                                //         ),
                                //       );
                                //   }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong password provided for that user.');
                                }
                              }
                            }
                            // if (_formSignInKey.currentState!.validate() &&
                            //     rememberPassword) {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Singlefilepicker()),);
                            //   // ScaffoldMessenger.of(context).showSnackBar(
                            //   //   const SnackBar(
                            //   //     content: Text('Processing Data'),
                            //   //   ),
                            //   // );
                            // } else if (!rememberPassword) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text(
                            //             'Please agree to the processing of personal data')),
                            //   );
                            // }
                          },
                          child: const Text('Sign In'),
                        ),
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),
                      //don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignUpScreen(),
                                ),
                              );
                            }, child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )
              ),
            ),
        ),
        ),
      ],
    ),
    );
  }
}
