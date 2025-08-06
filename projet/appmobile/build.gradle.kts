
id("com.android.application")id("com.google.gms.google-services")implementation(platform("com.google.firebase:firebase-bom:34.0.0"))implementation("com.google.firebase:firebase-analytics")
// Fichier android/app/build.gradle

apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services' //

android {
    namespace 'chinadeals.app'
    compileSdk 34

    defaultConfig {
        applicationId "chinadeals.app"
        minSdk 21
        targetSdk 34
        versionCode 1
        versionName "1.0"

        multiDexEnabled true
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }
}

dependencies {
    implementation 'com.google.firebase:firebase-analytics'
}