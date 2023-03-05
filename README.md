Flutter SDK


Integrating PayHere with your Flutter Mobile App is super easy with our PayHere Flutter SDK. You just have to include the package in your project dependencies, call its methods to initiate a payment and fetch the payment status just after the payment. The beauty is, this SDK allows you to accept a payment within your app, without redirecting your app user to the web browser.

Please refer the below steps to integrate PayHere Flutter SDK to your Mobile App.


1. Include PayHere Mobile SDK in your App
Open your Flutter project's pubspec.yaml file and add the PayHere Flutter SDK dependency.

dependencies:
  payhere_mobilesdk_flutter: ^3.0.1
Then run the following commands in your Flutter project directory.

flutter pub get

2. Set Android Pre-requisites
a. Add the PayHere Android SDK's Maven repository

Open up the (outermost) build.gradle file in your Android project and add the repository.

allprojects {
    repositories {
        mavenLocal()
        maven {
            url  "https://repo.repsy.io/mvn/payhere/payhere-mobilesdk-android/"
        }
    }
}
b. Allow Manifest attribute merge

Open up the AndroidManifest.xml file in your Anrdoid project and make the following changes.

i. Declare the Android tools namespace in the element.

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.domain.name"
    xmlns:tools="http://schemas.android.com/tools">
ii. Add the 'replace' merge rule for the 'android:label' attribute in the element.

<application tools:replace="android:label">

3. Set iOS Pre-requisites
Run the following command in your iOS Project.

pod install

4. Whitelist Mobile App Package Name
a. Login to your PayHere Merchant Account and navigate to Settings > Domains & Credentials.

b. Click the 'Add Domain/App' button.

c. Select 'App' from the first dropdown.

d. Add your Flutter App package name (e.g. lk.bhasha.helakuru).

e. Take note of the hash value in the last field. This is your Merchant Secret for this specific mobile App. You will need this in Step 5.

f. Click 'Request to Approve'.

(If you are using a PayHere Live Merchant Account, your App Package Name must be manually reviewed & approved. Please allow upto one business day for this review process to complete.)


5. Initiate a Payment Request to PayHere Payment Gateway
a. One-time Payment Request

Creates a one-time payment request charged only once. To capture the payment details from your server, read our docs.

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

Map paymentObject = {
  "sandbox": true,                 // true if using Sandbox Merchant ID
  "merchant_id": "1211149",        // Replace your Merchant ID
  "merchant_secret": "xyz",        // See step 4e
  "notify_url": "http://sample.com/notify",
  "order_id": "ItemNo12345",
  "items": "Hello from Flutter!",
  "amount": "50.00",
  "currency": "LKR",
  "first_name": "Saman",
  "last_name": "Perera",
  "email": "samanp@gmail.com",
  "phone": "0771234567",
  "address": "No.1, Galle Road",
  "city": "Colombo",
  "country": "Sri Lanka",
  "delivery_address": "No. 46, Galle road, Kalutara South",
  "delivery_city": "Kalutara",
  "delivery_country": "Sri Lanka",
  "custom_1": "",
  "custom_2": ""
};  

PayHere.startPayment(
  paymentObject, 
  (paymentId) {
    print("One Time Payment Success. Payment Id: $paymentId");
  }, 
  (error) { 
    print("One Time Payment Failed. Error: $error");
  }, 
  () { 
    print("One Time Payment Dismissed");
  }
);

b. Recurring Payment Request

Creates a subscription payment that is charged at a fixed frequency. To capture the payment details from your server, read our docs. You can learn more about PayHere Recurring Payments in our docs.

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

Map paymentObject = {
  "sandbox": true,                 // true if using Sandbox Merchant ID
  "merchant_id": "1211149",        // Replace your Merchant ID
  "merchant_secret": "xyz",        // See step 4e
  "notify_url": "http://sample.com/notify",
  "order_id": "ItemNo12345",
  "items": "Hello from Flutter!",
  "amount": "50.00",               // Recurring amount
  "recurrence": "1 Month",         // Recurring payment frequency
  "duration": "1 Year",            // Recurring payment duration
  "startup_fee": "10.00",          // Extra amount for first payment
  "currency": "LKR",
  "first_name": "Saman",
  "last_name": "Perera",
  "email": "samanp@gmail.com",
  "phone": "0771234567",
  "address": "No.1, Galle Road",
  "city": "Colombo",
  "country": "Sri Lanka",
  "delivery_address": "No. 46, Galle road, Kalutara South",
  "delivery_city": "Kalutara",
  "delivery_country": "Sri Lanka",
  "custom_1": "",
  "custom_2": ""
};

PayHere.startPayment(
  paymentObject, 
  (paymentId) {
    print("Recurring Payment Success. Payment Id: $paymentId");
  }, 
  (error) { 
    print("Recurring Payment Failed. Error: $error");
  }, 
  () { 
    print("Recurring Payment Dismissed");
  }
);

c. Preapproval Request

Tokenize customer card details for later usage with the PayHere Charging API. To capture the payment details from your server, read our docs. You can learn more about PayHere Automated Charging in our docs.

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

Map paymentObject = {
  "sandbox": true,                 // true if using Sandbox Merchant ID
  "preapprove": true,              // Required
  "merchant_id": "1211149",        // Replace your Merchant ID
  "merchant_secret": "xyz",        // See step 4e
  "notify_url": "http://sample.com/notify",
  "order_id": "ItemNo12345",
  "items": "Hello from Flutter!",
  "currency": "LKR",
  "first_name": "Saman",
  "last_name": "Perera",
  "email": "samanp@gmail.com",
  "phone": "0771234567",
  "address": "No.1, Galle Road",
  "city": "Colombo",
  "country": "Sri Lanka",
};

PayHere.startPayment(
  paymentObject, 
  (paymentId) {
    print("Tokenization Payment Success. Payment Id: $paymentId");
  }, 
  (error) { 
    print("Tokenization Payment Failed. Error: $error");
  }, 
  () { 
    print("Tokenization Payment Dismissed");
  }
);

d. Hold-on-Card Request

Authorize (hold) charges on a customer's card for later use with the PayHere Capture API. To capture the payment hold details from your server, read out docs.

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

Map paymentObject = {
  "sandbox": true,                // true if using Sandbox Merchant ID
  "authorize": true,              // Required
  "merchant_id": "1211149",       // Replace your Merchant ID
  "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
  "order_id": "ItemNo12345",
  "items": "Hello from Flutter!",
  "currency": "LKR",
  "amount": "50.00",
  "first_name": "Saman",
  "last_name": "Perera",
  "email": "samanp@gmail.com",
  "phone": "0771234567",
  "address": "No.1, Galle Road",
  "city": "Colombo",
  "country": "Sri Lanka",
};

PayHere.startPayment(paymentObject, (paymentId) {
  print("Hold-on-Card Payment Success.");
}, (error) {
  print("Hold-on-Card Payment Failed. Error: $error");
}, () {
  print("Hold-on-Card Payment Dismissed");
});

6. Optionally, pass Item-wise Details
Each item has four parameters. Their parameter names must be followed by the index of that item. For example:

  "item_number_1": "ITM001",
  "item_name_1": "PayHere Sticker",
  "quantity_1": "2",
  "amount_1": "25.0",
An example Onetime payment request with 2 items is shown below.

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

Map paymentObject = {
  "sandbox": true, 
  "merchant_id": "1211149",             // Replace your Merchant ID
  "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
  "order_id": "ItemNo12345",
  "items": "Hello from Flutter!",

  "item_number_1": "001",               // ** Item 1 **
  "item_name_1": "Test Item #1",        
  "amount_1": "15.00",                  
  "quantity_1": "2",                    
  "item_number_2": "002",               // ** Item 2 **
  "item_name_2": "Test Item #2",        
  "amount_2": "20.00",                  
  "quantity_2": "1",                    
  
  "amount": 50.00,
  "currency": "LKR",
  "first_name": "Saman",
  "last_name": "Perera",
  "email": "samanp@gmail.com",
  "phone": "0771234567",
  "address": "No.1, Galle Road",
  "city": "Colombo",
  "country": "Sri Lanka",
  "delivery_address": "No. 46, Galle road, Kalutara South",
  "delivery_city": "Kalutara",
  "delivery_country": "Sri Lanka",
  "custom_1": "",
  "custom_2": ""
};

PayHere.startPayment(
  paymentObject, (paymentId) {
    print("One Time Payment Success. Payment Id: $paymentId");
  }, (error) { 
    print("One Time Payment Failed. Error: $error");
  }, () { 
    print("One Time Payment Dismissed");
  }
);

FAQ
What versions of Flutter are supported?

Flutter versions above 1.20.0 are supported.
What versions of iOS are supported?

The iOS component for this SDK supports iOS Versions above 11.0.
What versions of Android are supported?

The Android component for this SDK supports Android Versions above API Level 17.
What are the parameters for the PayHere.startPayment method?

PayHere.startPayment(
  paymentObject,          // The payment parameters as a Map<String, dynamic>.
  onCompletedHandler,     // Function called with the PayHere Payment ID (String), for succesful payments
  onErrorHandler,         // Function called with the Error (String), if an error occured
  onDismissedHandler      // Function called if the payment popup closed before payments are processed
);
How to get payment details such as payment method, status, card holder etc.?

You must setup a Server Endpoint that accepts the asynchronous PayHere Payment Notification POST request, and pass its URL to the notify_url parameter of the paymentObject.
Each payment request type (one-time/recurring/pre-approval) sends a different payment notification. Study the following sections for more information.
One-time Payment Details: Read docs
Recurring Payment Details: Read docs
Preapproval Details: Read docs
I am getting an error saying, "Could not GET 'https://dl.bintray.com..."

Update to the latest version 1.0.2 and try again. Make sure you have followed the new "2. Android Pre-requisites" section with updated instructions for SDK versions 1.0.2 and above.
Does this package support Flutter Null Safety?

Yes! Version 1.0.3 and up opts into Flutter Null Safety. You only need to upgrade to version ^1.0.3.
I am not using Flutter Null Safety, which version should I use?

Use version 1.0.2. The rest of the instructions and documentation would still apply as is.
I have a different question. Where should I raise my issues?

You can raise issues directly at the Issues section for the SDK's GitHub page.
Related Links:

Pub.dev Package
GitHub Repository
