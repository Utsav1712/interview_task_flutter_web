import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image/Gradient
          _buildBackground(),
          
          // Content
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return _buildDesktopLayout();
              } else if (constraints.maxWidth > 600) {
                return _buildTabletLayout();
              } else {
                return _buildMobileLayout();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        gradient: RadialGradient(
          center: const Alignment(0.7, -0.6),
          radius: 1.5,
          colors: [
            AppColors.surface,
            AppColors.background,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/crypto_gaming.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Subtle circular glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cryptoGold.withOpacity(0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left Side: Illustration & Branding
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBranding(),
                const SizedBox(height: 48),
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'illustration',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          'assets/images/crypto_gaming.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  "FAIR • FAST • SECURE",
                  style: AppTextStyles.caption.copyWith(
                    letterSpacing: 4,
                    color: AppColors.cryptoGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Right Side: Login Form
        Expanded(
          flex: 1,
          child: Center(
            child: _buildLoginForm(width: 450),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: _buildLoginForm(width: 500),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildBranding(),
            const SizedBox(height: 32),
            _buildLoginForm(width: double.infinity, isMobile: true),
          ],
        ),
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.cryptoGold, AppColors.cryptoGold.withOpacity(0.5)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cryptoGold.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.currency_bitcoin, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "CRYPTO",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.cryptoGold,
                      letterSpacing: 2,
                    ),
                  ),
                  TextSpan(
                    text: "360",
                    style: AppTextStyles.heading1.copyWith(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "The Ultimate Crypto Casino Experience",
          style: AppTextStyles.body.copyWith(
            color: AppColors.secondary,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm({required double width, bool isMobile = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.cryptoGold.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("VIP Access", style: AppTextStyles.heading2.copyWith(color: AppColors.cryptoGold)),
              const SizedBox(height: 8),
              Text(
                "Login to access your private vault and tables.",
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 32),
              
              // Email Field
              _buildTextField(
                label: "Username or Email",
                hint: "Satoshi_Nakamoto",
                controller: controller.emailController,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 24),
              
              // Password Field
              Obx(() => _buildTextField(
                    label: "Secure Password",
                    hint: "••••••••",
                    controller: controller.passwordController,
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: !controller.isPasswordVisible.value,
                    onToggleVisibility: controller.togglePasswordVisibility,
                  )),
              
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot access code?",
                    style: AppTextStyles.caption.copyWith(color: AppColors.cryptoGold),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(() => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [AppColors.cryptoGold, const Color(0xFFB8860B)],
                    ),
                    boxShadow: [
                      if (!controller.isLoading.value)
                        BoxShadow(
                          color: AppColors.cryptoGold.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppColors.primary,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : Text("ENTER VAULT", style: AppTextStyles.button.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                )),
              ),
              
              const SizedBox(height: 32),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text("New high roller? ", style: AppTextStyles.caption),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Join the club",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.cryptoGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.cryptoGold.withOpacity(0.8))),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.body.copyWith(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.secondary.withOpacity(0.3)),
            prefixIcon: Icon(icon, color: AppColors.cryptoGold.withOpacity(0.5), size: 20),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.cryptoGold.withOpacity(0.5),
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            filled: true,
            fillColor: AppColors.primary.withOpacity(0.3),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.cryptoGold.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.cryptoGold),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
