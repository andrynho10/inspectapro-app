package com.inspectapro.demo.utils

import android.util.Log

/**
 * Gestor de notificaciones push (Firebase Cloud Messaging).
 *
 * VERSIÓN DEMO: el push está deshabilitado. En el sistema original el token FCM se guardaba
 * en la tabla `fcm_tokens` y una Edge Function enviaba el push a los supervisores cuando una
 * inspección tenía fallas. En la demo ese envío se SIMULA en la base de datos
 * (tabla `notificaciones_simuladas`), por lo que no se requiere un proyecto Firebase.
 */
object FcmManager {
    private const val TAG = "FcmManager"

    suspend fun registerFcmToken(usuarioId: String): Boolean {
        Log.d(TAG, "Demo: push deshabilitado, no se registra token para $usuarioId")
        return false
    }

    suspend fun unregisterFcmToken(usuarioId: String): Boolean {
        Log.d(TAG, "Demo: push deshabilitado, nada que eliminar para $usuarioId")
        return true
    }

    suspend fun deleteFcmToken(): Boolean = true
}
