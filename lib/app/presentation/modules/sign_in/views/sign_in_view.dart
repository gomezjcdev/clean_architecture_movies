import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';
  final bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) => setState(() {
                    _username = value.trim().toLowerCase();
                  }),
                  decoration: const InputDecoration(hintText: 'username'),
                  validator: (value) {
                    value = value?.trim().toLowerCase() ?? '';

                    return value.isEmpty ? 'Invalid username' : null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) => setState(() {
                    _password = value.replaceAll(' ', '').toLowerCase();
                  }),
                  decoration: const InputDecoration(hintText: 'password'),
                  validator: (value) {
                    value = value?.replaceAll(' ', '').toLowerCase() ?? '';

                    return value.length < 4 ? 'Invalid password' : null;
                  },
                ),
                const SizedBox(height: 20),
                Builder(builder: (context) {
                  return MaterialButton(
                    onPressed: () {
                      final isValid = Form.of(context)!.validate();

                      if (isValid) {
                        _submit();
                      }
                    },
                    color: Colors.blue,
                    child: const Text('SignIn'),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() {}
}
