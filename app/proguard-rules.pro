# Add project specific ProGuard rules here.

# Configuración balanceada: Ofuscar pero no optimizar agresivamente
# Esto reduce el tamaño del APK manteniendo compatibilidad con Kotlinx Serialization
-dontoptimize
# Permitimos ofuscación pero protegiendo las clases críticas
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Mantener información de líneas para stack traces útiles
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Kotlin Serialization - CRÍTICO para Supabase
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt

# Mantener todas las clases serializables
-keep,includedescriptorclasses class com.inspectapro.demo.**$$serializer { *; }

# Mantener los companion objects que contienen los serializers
-keepclassmembers class com.inspectapro.demo.** {
    *** Companion;
}

# Mantener los métodos serializer()
-keepclasseswithmembers class com.inspectapro.demo.** {
    kotlinx.serialization.KSerializer serializer(...);
}

# Mantener todas las clases anotadas con @Serializable
-keep @kotlinx.serialization.Serializable class com.inspectapro.demo.** { *; }

# Mantener Kotlinx Serialization
-keep class kotlinx.serialization.** { *; }
-keepclassmembers class kotlinx.serialization.** {
    *;
}

# Ktor Client - necesario para las llamadas HTTP de Supabase
-keep class io.ktor.** { *; }
-keep class kotlinx.coroutines.** { *; }
-dontwarn io.ktor.**
-dontwarn kotlinx.atomicfu.**
-dontwarn org.slf4j.**

# Supabase - CRÍTICO para comunicación con servidor
-keep class io.github.jan.supabase.** { *; }
-keepclassmembers class io.github.jan.supabase.** { *; }
-dontwarn io.github.jan.supabase.**

# Supabase Postgrest (para queries)
-keep class io.github.jan.supabase.postgrest.** { *; }
-keep class io.github.jan.supabase.storage.** { *; }
-keep class io.github.jan.supabase.gotrue.** { *; }

# Room Database - mantener entidades y DAOs
-keep class * extends androidx.room.RoomDatabase
-keep @androidx.room.Entity class *
-dontwarn androidx.room.paging.**

# Gson (para serialización en Room)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Modelos de datos - mantener todos los campos (CRÍTICO)
-keep class com.inspectapro.demo.data.models.** { *; }
-keep class com.inspectapro.demo.data.local.entities.** { *; }

# Mantener específicamente los modelos de plantillas
-keep class com.inspectapro.demo.data.models.PlantillaChecklist { *; }
-keep class com.inspectapro.demo.data.models.CategoriaPlantilla { *; }
-keep class com.inspectapro.demo.data.models.PreguntaPlantilla { *; }
-keep class com.inspectapro.demo.data.models.RespuestaReporte { *; }
-keep class com.inspectapro.demo.data.models.ReporteInspeccion { *; }
-keep class com.inspectapro.demo.data.models.FotoRespuesta { *; }
-keep class com.inspectapro.demo.data.models.Activo { *; }
-keep class com.inspectapro.demo.data.models.Usuario { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Coil (carga de imágenes)
-keep class coil.** { *; }
-dontwarn coil.**

# ZXing (códigos QR)
-keep class com.google.zxing.** { *; }
-dontwarn com.google.zxing.**

# WorkManager
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**

# Retrofit/OkHttp (si se usan indirectamente)
-dontwarn okhttp3.**
-dontwarn okio.**

# Proteger solo lo necesario (permite ofuscar ViewModels, Repositories, etc.)
# Mantener Activities, Fragments y Composables
-keep class com.inspectapro.demo.MainActivity { *; }
-keep class com.inspectapro.demo.ui.screens.** { *; }
-keep class com.inspectapro.demo.ui.components.** { *; }

# IMPORTANTE: Mantener nombres de campos para serialización JSON
# Esto es crítico para que Supabase pueda mapear los campos correctamente
-keepclassmembers class com.inspectapro.demo.data.models.** {
    <fields>;
}

# Mantener anotaciones de Kotlinx Serialization
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault

# Reflection (usado por Kotlinx Serialization)
-keepattributes *Annotation*
-keep class kotlin.Metadata { *; }
-keep class kotlin.reflect.** { *; }
-dontwarn kotlin.reflect.**