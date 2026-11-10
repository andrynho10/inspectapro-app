package com.inspectapro.demo

import android.app.Application
import com.inspectapro.demo.data.sync.ConnectivitySyncTrigger
import com.inspectapro.demo.workers.SyncWorker

/**
 * Clase Application personalizada para inicialización de servicios globales
 */
class InspectaProApplication : Application() {

    private lateinit var connectivitySyncTrigger: ConnectivitySyncTrigger

    override fun onCreate() {
        super.onCreate()

        // Inicializar sincronización periódica en background (cada 15 min)
        SyncWorker.schedulePeriodic(this)
        android.util.Log.d("InspectaProApplication", "WorkManager programado (sincronización cada 15 min)")

        // Inicializar sincronización automática al recuperar conexión
        connectivitySyncTrigger = ConnectivitySyncTrigger(this)
        connectivitySyncTrigger.iniciar()
        android.util.Log.d("InspectaProApplication", "Sincronización automática al recuperar conexión activada")

        android.util.Log.d("InspectaProApplication", "═══════════════════════════════════════")
        android.util.Log.d("InspectaProApplication", "APLICACIÓN INICIALIZADA")
        android.util.Log.d("InspectaProApplication", "Soporte offline completo activado")
        android.util.Log.d("InspectaProApplication", "Sincronización automática configurada")
        android.util.Log.d("InspectaProApplication", "Push FCM deshabilitado en la demo (notificaciones simuladas en el servidor)")
        android.util.Log.d("InspectaProApplication", "═══════════════════════════════════════")
    }
}
