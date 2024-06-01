import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
             Color.fromARGB(255, 0, 0, 0), 
             Color.fromARGB(255, 28, 107, 116), 
             Color(0xFF2C5364)
            ],
          ),
        ),
        child: const SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding:  EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
               Text(
                '''

1. Introduction
Welcome to Musific! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application. By using Musific, you agree to the collection and use of information in accordance with this policy.

2. Information We Collect
a. Personal Information:
- Name
- Email address
- Contact information

b. Usage Data:
- App usage patterns
- Device information (such as device type, operating system)
- Log data (such as IP address, access times)

3. How We Use Your Information
We use the collected information to:
- Provide and maintain the app
- Improve the app's functionality and user experience
- Personalize user experience
- Communicate with users regarding updates, promotions, and customer support
- Analyze usage data to make app improvements

4. Information Sharing and Disclosure
We do not share your personal information with third parties except:
- With your consent
- To comply with legal obligations
- To protect and defend our rights and property
- With service providers to perform app-related services (such as data storage and processing)
- In connection with a merger, sale, or acquisition of all or part of our business

5. Data Security
We implement reasonable security measures to protect your data from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or method of electronic storage is 100% secure.

6. Your Data Rights
You have the right to:
- Access the information we hold about you
- Request correction of inaccurate data
- Request deletion of your data
- Object to processing of your data
- Withdraw consent at any time, where relevant

7. Children's Privacy
Musific is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under age 13 without verification of parental consent, we take steps to remove that information from our servers.

8. Changes to This Privacy Policy
We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy within the app. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted in the app.

9. Contact Us
If you have any questions about this Privacy Policy, please contact us at:
- Email: thomasalbin35@gmail.com
- Address:

10. Consent
By using Musific, you consent to our collection and use of your personal information as described in this Privacy Policy.
                ''',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
