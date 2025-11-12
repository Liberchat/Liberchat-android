plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.liberchat.mobile"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.liberchat.mobile"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 35
        versionName = "3.5.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Dépendances pour les captures d'écran Fastlane (optionnelles)
    // androidTestImplementation("tools.fastlane:screengrab:2.1.1")
    // androidTestImplementation("androidx.test:runner:1.5.2")
    // androidTestImplementation("androidx.test:rules:1.5.0")
    // androidTestImplementation("androidx.test.ext:junit:1.1.5")
    // androidTestImplementation("androidx.test.uiautomator:uiautomator:2.2.0")
}
