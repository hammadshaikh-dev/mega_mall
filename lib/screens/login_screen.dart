import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // Import the package

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Local Auth instance
  final LocalAuthentication auth = LocalAuthentication(); 
  
  // New state variable to track biometric availability
  bool _canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricsAvailability();
  }

  // Check and update state on whether biometrics can be used
  Future<void> _checkBiometricsAvailability() async {
    bool canCheckBiometrics = false;
    bool isDeviceSupported = false;

    try {
      // Check if the device has biometric capabilities
      canCheckBiometrics = await auth.canCheckBiometrics;
      // Check if the current device is supported (SDK checks)
      isDeviceSupported = await auth.isDeviceSupported();
    } catch (e) {
      debugPrint("Error checking biometrics: $e");
    }

    if (canCheckBiometrics && isDeviceSupported) {
      // Only set state if the widget is still mounted
      if (mounted) {
        setState(() {
          _canCheckBiometrics = true;
        });
      }
    }
  }
  
  // --- Biometric Logic ---

  Future<void> _authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
        // FIX: Reverted to using the required named parameter 'localizedReason'
        localizedReason: 'Scan your fingerprint to quickly log into Mega Mall', 
      );

      if (authenticated) {
        _successfulLogin();
      } else {
        _showErrorSnackbar('Biometric authentication failed or cancelled.');
      }
    } catch (e) {
      _showErrorSnackbar('An error occurred during authentication: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    // Ensure context is available before using ScaffoldMessenger
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _successfulLogin() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  // Form Validation Logic
  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      // Perform email/password authentication here.
      // Assuming successful login for now:
      _successfulLogin(); 
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                
                // Row to hold Login Button and Fingerprint Button
                Row(
                  children: [
                    // Primary Login Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    
                    // Conditionally display the Fingerprint Button
                    if (_canCheckBiometrics) ...[
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.fingerprint, size: 30),
                        onPressed: _authenticateWithBiometrics,
                        color: Colors.blueAccent,
                        tooltip: 'Login with Fingerprint',
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Don\'t have an account? Sign Up here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}