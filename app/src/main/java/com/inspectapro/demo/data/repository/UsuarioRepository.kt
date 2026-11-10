package com.inspectapro.demo.data.repository

import com.inspectapro.demo.data.models.Usuario
import com.inspectapro.demo.data.supabase.SupabaseClient
import io.github.jan.supabase.postgrest.from

class UsuarioRepository {
    private val client = SupabaseClient.client

    suspend fun obtenerTodosLosUsuarios(): List<Usuario> {
        return try {
            client.from("usuarios").select().decodeList<Usuario>()
        } catch (e: Exception) {
            android.util.Log.e("UsuarioRepository", "Error obteniendo usuarios: ${e.message}")
            emptyList()
        }
    }

    suspend fun obtenerUsuarioPorId(userId: String): Usuario? {
        return try {
            client.from("usuarios").select {
                filter {
                    Usuario::id eq userId
                }
            }.decodeSingle<Usuario>()
        } catch (e: Exception) {
            android.util.Log.e("UsuarioRepository", "Error obteniendo usuario por ID: ${e.message}")
            null
        }
    }
}