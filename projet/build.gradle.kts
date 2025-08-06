id("com.google.gms.google-services") version "4.4.3" apply false
// Fichier android/build.gradle

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.2'
        classpath 'com.google.gms:google-services:4.3.15' // 🔥 Nécessaire pour Firebase
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}