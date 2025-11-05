import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const SignupAdventureApp());
}

class SignupAdventureApp extends StatelessWidget {
  const SignupAdventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Adventure',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedAvatar;

  final List<String> _avatars = ['😊', '🚀', '🐱', '🌸', '🔥'];
  bool _isPasswordVisible = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  // Password Strength Meter
  Widget _passwordStrengthMeter(String password) {
    double strength = 0;
    if (password.isEmpty) strength = 0;
    else if (password.length < 6) strength = 0.25;
    else if (password.length < 10) strength = 0.5;
    else if (password.length < 14) strength = 0.75;
    else strength = 1.0;

    Color color;
    if (strength <= 0.25) color = Colors.red;
    else if (strength <= 0.5) color = Colors.orange;
    else if (strength <= 0.75) color = Colors.yellow;
    else color = Colors.green;

    return LinearProgressIndicator(
      value: strength,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(color),
      minHeight: 8,
    );
  }

  // Progress Tracker
  double _calculateProgress() {
    double progress = 0;
    if (_nameController.text.isNotEmpty) progress += 0.25;
    if (_emailController.text.isNotEmpty) progress += 0.25;
    if (_passwordController.text.isNotEmpty) progress += 0.25;
    if (_selectedAvatar != null) progress += 0.25;
    return progress;
  }

  Widget _buildProgressBar() {
    double progress = _calculateProgress();
    String milestone = '';
    if (progress == 0.25) milestone = 'Great start!';
    else if (progress == 0.5) milestone = 'Halfway there!';
    else if (progress == 0.75) milestone = 'Almost done!';
    else if (progress == 1.0) milestone = 'Ready for adventure!';

    if (progress > 0) _confettiController.play();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          minHeight: 10,
        ),
        const SizedBox(height: 6),
        if (milestone.isNotEmpty)
          Text(
            milestone,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAvatar == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an avatar!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            name: _nameController.text,
            avatar: _selectedAvatar!,
            password: _passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join the Adventure!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Create Your Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  validator: (val) {
                    if (val!.isEmpty) return 'Please enter email';
                    if (!val.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) return 'Enter password';
                    if (val.length < 6) return 'Password too short';
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                _passwordStrengthMeter(_passwordController.text),
                const SizedBox(height: 16),
                _buildProgressBar(),
                const SizedBox(height: 16),
                const Text(
                  'Choose your Avatar:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  children: _avatars.map((emoji) {
                    final isSelected = _selectedAvatar == emoji;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAvatar = emoji),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            isSelected ? Colors.deepPurple : Colors.grey[300],
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12)),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.purple,
                    Colors.blue,
                    Colors.green,
                    Colors.orange
                  ],
                  numberOfParticles: 20,
                  maxBlastForce: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
          {required TextEditingController controller,
          required String label,
          required IconData icon,
          required String? Function(String?) validator}) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      );
}

class SuccessScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final String password;
  const SuccessScreen(
      {super.key, required this.name, required this.avatar, required this.password});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late ConfettiController _confettiController;
  final List<String> _badges = [];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
    _checkBadges();
  }

  void _checkBadges() {
    _badges.clear();
    if (widget.password.length >= 10) _badges.add('Strong Password Master');
    final hour = DateTime.now().hour;
    if (hour < 12) _badges.add('The Early Bird Special');
    if (widget.name.isNotEmpty) _badges.add('Profile Completer');
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.purple,
                Colors.blue,
                Colors.green,
                Colors.orange
              ],
              numberOfParticles: 30,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.avatar, style: const TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome, ${widget.name}!',
                      textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                const SizedBox(height: 20),
                const Text(
                  '🎉 Account created successfully! 🎉',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  children: _badges
                      .map((b) => Chip(
                            label: Text(b),
                            backgroundColor: Colors.deepPurple[100],
                          ))
                      .toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _confettiController.play(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15)),
                  child: const Text('More Celebration!',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
