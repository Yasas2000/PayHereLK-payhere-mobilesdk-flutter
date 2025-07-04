# PayHere Flutter SDK Integration Guide

Integrate PayHere seamlessly into your Flutter mobile app and accept payments within your app—no browser redirection required!

---

## 1. Include the PayHere Mobile SDK

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  payhere_mobilesdk_flutter: ^3.0.1
```

Run:

```bash
flutter pub get
```

---

## 2. Android Setup

### a. Add Maven Repository

In your root `build.gradle`:

```gradle
allprojects {
  repositories {
    mavenLocal()
    maven {
      url "https://repo.repsy.io/mvn/payhere/payhere-mobilesdk-android/"
    }
  }
}
```

### b. Manifest Merge Rules

Edit `AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.domain.name"
    xmlns:tools="http://schemas.android.com/tools">
```

Inside `<application>`:

```xml
<application tools:replace="android:label">
```

---

## 3. iOS Setup

Run:

```bash
pod install
```

---

## 4. Whitelist App Package Name

* Log into your PayHere Merchant account
* Go to: **Settings > Domains & Credentials**
* Add your app’s package name (e.g., `lk.bhasha.helakuru`)
* Copy the generated hash value (Merchant Secret)
* Click **Request to Approve** (approval may take 1 business day)

---

## 5. Initiate a Payment

### a. One-Time Payment

```dart
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

Map payment = {
  "sandbox": true,
  "merchant_id": "1211149",
  "merchant_secret": "xyz",
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
};

PayHere.startPayment(payment, (id) {
  print("Payment Success: \$id");
}, (error) {
  print("Payment Failed: \$error");
}, () {
  print("Payment Dismissed");
});
```

### b. Recurring Payment

Add keys like `recurrence`, `duration`, and `startup_fee`. See official docs for full details.

### c. Preapproval Request

Set `"preapprove": true` to tokenize card for later use.

### d. Hold-on-Card Request

Set `"authorize": true` to authorize payment for later capture.

---

## 6. Add Item-wise Details (Optional)

```dart
"item_number_1": "001",
"item_name_1": "Test Item #1",
"quantity_1": "2",
"amount_1": "25.00",
"item_number_2": "002",
"item_name_2": "Test Item #2",
"quantity_2": "1",
"amount_2": "20.00",
```

Set total `amount` and follow the same `PayHere.startPayment()` procedure.

---

## FAQ

* **Flutter Version:** Supports 1.20.0 and above
* **Android:** API level 17+
* **iOS:** iOS 11+
* **Null Safety:** Supported in SDK v1.0.3+
* **Non-Null Safety:** Use v1.0.2
* **Error: Could not GET Bintray:** Follow updated Android setup and use v1.0.2+
* **Payment Details:** Use `notify_url` on your backend to capture data

---

## Useful Links

* [Pub.dev](https://pub.dev/packages/payhere_mobilesdk_flutter)
* [GitHub Issues](https://github.com/PayHereLK/payhere-mobilesdk-flutter/issues)

---

Happy coding with PayHere! 🎉
