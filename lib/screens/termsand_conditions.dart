import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

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
                    'Terms and Conditions',
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
Welcome to Musific! These terms and conditions outline the rules and regulations for the use of Musific's mobile application.

By accessing this mobile application, we assume you accept these terms and conditions. Do not continue to use Musific if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement, and Disclaimer Notice and all agreements: "Client", "You" and "Your" refers to you, the person log on this mobile application and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.

License

Unless otherwise stated, Musific and/or its licensors own the intellectual property rights for all material on Musific. All intellectual property rights are reserved. You may access this from Musific for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

Republish material from Musific
Sell, rent, or sub-license material from Musific
Reproduce, duplicate, or copy material from Musific
Redistribute content from Musific
This Agreement shall begin on the date hereof.

Parts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the app. Musific does not filter, edit, publish or review Comments prior to their presence on the app. Comments do not reflect the views and opinions of Musific, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Musific shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this app.

Musific reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

You warrant and represent that:

You are entitled to post the Comments on our app and have all necessary licenses and consents to do so;
The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;
The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy;
The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.
You hereby grant Musific a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.

Hyperlinking to our Content

The following organizations may link to our Mobile Application without prior written approval:

Government agencies;
Search engines;
News organizations;
Online directory distributors may link to our Mobile Application in the same manner as they hyperlink to the Mobile Applications of other listed businesses; and
System-wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Mobile Application.
These organizations may link to our home page, to publications or to other Mobile Application information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.

We may consider and approve other link requests from the following types of organizations:

commonly-known consumer and/or business information sources;
dot.com community sites;
associations or other groups representing charities;
online directory distributors;
internet portals;
accounting, law and consulting firms; and
educational institutions and trade associations.
We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Musific; and (d) the link is in the context of general resource information.

These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Musific. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Mobile Application, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our Mobile Application as follows:

By use of our corporate name; or
By use of the uniform resource locator being linked to; or
By use of any other description of our Mobile Application being linked to that makes sense within the context and format of content on the linking party’s site.
No use of Musific's logo or other artwork will be allowed for linking absent a trademark license agreement.

iFrames

Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Mobile Application.

Content Liability

We shall not be hold responsible for any content that appears on your Mobile Application. You agree to protect and defend us against all claims that is rising on your Mobile Application. No link(s) should appear on any Mobile Application that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.

Your Privacy

Please read Privacy Policy

Reservation of Rights

We reserve the right to request that you remove all links or any particular link to our Mobile Application. You approve to immediately remove all links to our Mobile Application upon request. We also reserve the right to amend these terms and conditions and it’s linking policy at any time. By continuously linking to our Mobile Application, you agree to be bound to and follow these linking terms and conditions.
                ''',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
