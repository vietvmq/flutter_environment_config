# Android Setup Guide

A step-by-step guide to configure Flutter Environment Config for Android projects.

## 📁 Create Environment Files

First, create environment files in your project root:

```text
my_app/
├── .env.develop         # Development environment
├── .env.staging         # Staging environment
├── .env.production      # Production environment
├── pubspec.yaml
└── android/
    └── app/
        └── build.gradle
```

**Example `.env.develop`:**

```bash
APP_NAME=[DEV] My App
APP_ID=com.dev.my_app
VERSION_CODE=1
VERSION_NAME=1.0.0-dev
API_URL=https://dev-api.my_app.com
API_KEY=dev-key-123
DEBUG_MODE=true
```

**Example `.env.staging`:**

```bash
APP_NAME=[STAGING] My App
APP_ID=com.staging.my_app
VERSION_CODE=1
VERSION_NAME=1.0.0-staging
API_URL=https://staging-api.my_app.com
API_KEY=staging-key-456
DEBUG_MODE=false
```

**Example `.env.production`:**

```bash
APP_NAME=My App
APP_ID=com.my_app
VERSION_CODE=1
VERSION_NAME=1.0.0
API_URL=https://api.my_app.com
API_KEY=prod-key-789
DEBUG_MODE=false
```

## 🚀 Quick Setup

### 1. Apply the Plugin

In your `android/app/build.gradle` file:

```gradle
// Environment file mapping (optional - for multiple environments)
project.ext.envConfigFiles = [
    develop: ".env.develop",
    staging: ".env.staging",
    production: ".env.production"
]

apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
apply from: project(':flutter_environment_config').projectDir.getPath() + "/dotenv.gradle"
```

### 2. ProGuard Configuration (Release Builds)

Create `android/app/proguard-rules.pro`:

```proguard
# Keep BuildConfig class and all its fields
-keep class **.BuildConfig { *; }
```

Add to `android/app/build.gradle`:

```gradle
android {
    buildTypes {
        release {
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

## 💻 Usage

### Gradle Configuration

```gradle
android {
    defaultConfig {
        applicationId project.env.get("APP_ID") ?: "com.example.my_app"
        versionName project.env.get("VERSION_NAME")
        versionCode project.env.get("VERSION_CODE").toInteger()
    }
}
```

### AndroidManifest.xml

```xml
<application>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="@string/GOOGLE_MAPS_API_KEY" />

    <meta-data
        android:name="firebase_analytics_collection_enabled"
        android:value="@string/ENABLE_ANALYTICS" />
</application>
```

### Kotlin

```kotlin
class ApiService {
    private val apiUrl = BuildConfig.API_URL
    private val apiKey = BuildConfig.API_KEY
    private val debugMode = BuildConfig.DEBUG_MODE.toBoolean()

    fun createHttpClient(): OkHttpClient {
        return OkHttpClient.Builder()
            .addInterceptor { chain ->
                val request = chain.request().newBuilder()
                    .addHeader("Authorization", "Bearer $apiKey")
                    .build()
                chain.proceed(request)
            }
            .build()
    }
}
```

### Java

```java
public class ApiService {
    private static final String API_URL = BuildConfig.API_URL;
    private static final String API_KEY = BuildConfig.API_KEY;

    public HttpURLConnection createConnection() throws IOException {
        URL url = new URL(API_URL + "/api/data");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", "Bearer " + API_KEY);
        return connection;
    }
}
```

### Build Flavors Configuration

Configure Android build flavors in `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        applicationId project.env.get("APP_ID")
        versionName project.env.get("VERSION_NAME")
        versionCode project.env.get("VERSION_CODE").toInteger()

        // Required if package name differs from applicationId
        resValue "string", "build_config_package", "com.my_package.my_app"
    }

    flavorDimensions "environment"
    productFlavors {
        develop {
            dimension "environment"
            applicationIdSuffix ".dev"
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
        }
        production {
            dimension "environment"
            applicationIdSuffix ""
        }
    }
}
```

### Build Commands

```bash
# Build development APK
flutter build apk --flavor develop

# Build staging APK
flutter build apk --flavor staging

# Build production APK
flutter build apk --flavor production

# Run on device with specific flavor
flutter run --flavor develop
```

## ⚠️ Security

**Environment variables are embedded in your APK and can be extracted.**

### Never store

- API secrets and private keys
- Database credentials
- Signing certificates

### Safe to store

- API endpoints and URLs
- Feature flags
- Debug settings

## 🆘 Troubleshooting

**Variables are null in release:**

- Check ProGuard rules are applied
- Verify environment files are loaded

**Variables not updating:**

- Run `flutter clean && flutter pub get`
- Verify file paths and syntax

For help, check the [example implementation](../example/) or open an issue.
