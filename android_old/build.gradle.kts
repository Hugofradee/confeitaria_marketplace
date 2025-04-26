plugins {
    id("com.android.application")
    kotlin("android")
}

android {
    namespace = "com.hugo.confeitaria_marketplace"
    compileSdk = 34
    ndkVersion = "27.0.12077973" // ✅ aqui!

    defaultConfig {
        applicationId = "com.hugo.confeitaria_marketplace"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.10.1")
    implementation("androidx.appcompat:appcompat:1.6.1")
    // outras dependências aqui
}
