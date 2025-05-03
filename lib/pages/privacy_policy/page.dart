import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyPage extends ConsumerWidget {
  const PrivacyPolicyPage({super.key});

  static const routeName = '/privacy-policy';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text('''
# Privacy Policy

Your privacy is important to us, and we are committed to protecting the personal information of all riders who use our platform. This Privacy Policy outlines how we collect, use, share, and protect your information when you sign up and use our app.

---

## 1. Information We Collect

### 1.1 Personal Information
When you sign up and use the app, we collect the following:

- Full Name  
- Email Address  
- Phone Number  
- Profile Photo  
- Government-Issued ID (Driver’s License, National ID, or Passport)  
- Emergency Contact Information  

### 1.2 Location Data
We collect real-time GPS location to help you find deliveries near you and track your trips.  
**Note:** Location tracking is only active when you are online and accepting orders.

### 1.3 Financial Information
- Bank Account or Mobile Wallet Details (to process earnings and withdrawals)  
- Transaction History (for payment records)  

### 1.4 Device Information
- Device Model & OS Version (to ensure app compatibility)  
- App Usage Data (to improve app performance and fix bugs)  

---

## 2. How We Use Your Information

We collect this data to:

- ✅ Verify your identity and ensure security  
- ✅ Process delivery requests and connect you with customers  
- ✅ Track your rides in real-time to provide accurate earnings reports  
- ✅ Process withdrawals and payments  
- ✅ Improve our services by analyzing rider activity  
- ✅ Prevent fraud and unauthorized access  

---

## 3. How We Share Your Information

We **DO NOT** sell your personal information. However, we may share your data in the following cases:

- **With Customers & Restaurants:** Your name, profile photo, and live location are shared when delivering an order.  
- **With Payment Providers:** To process your withdrawals securely.  
- **With Law Enforcement:** If required by law, we may disclose information for legal or safety reasons.  

---

## 4. Data Security

- 🔒 We use encryption and secure servers to protect your information.  
- ✅ Only authorized personnel have access to sensitive data.  
- 📌 Your financial details are not stored on our servers—they are securely handled by payment partners.  

---

## 5. Your Privacy Rights

You have the right to:

- ✔ Access and update your personal details in the app settings  
- ✔ Enable or disable location tracking at any time  
- ✔ Request data deletion if you stop using the platform  

To request data access or deletion, contact us at:  
📧 **support@[yourappname].com**

---

## 6. Cookies & Tracking Technologies

We use tracking tools to analyze app performance and enhance user experience.  
You can manage these settings in your device preferences.

---

## 7. Changes to This Privacy Policy

We may update this Privacy Policy from time to time.  
If changes are made, we will notify you via the app or email.

---

## 8. Contact Us

📩 Email: **support@[yourappname].com**  
📞 Phone: **+[Your Contact Number]**  
📍 Office Address: **[Company Address]**

---

By using **[Your App Name]**, you agree to the terms outlined in this Privacy Policy.

        '''),
      ),
    );
  }
}
