# ARCHITECTURE.md

## Flujo de Automatización (ASCII)

```
          +------------------+
          |  network-discovery.sh
          +------------------+
                   |
   +-------------------------------+
   |                               |
+------+                  +------------------+
|masscan|                 |  ping-sweep      |
+------+                  +------------------+
   |                                |
   +----------------+---------------+
                    |
           +---------------------+
           |   port-scan.sh      |
           +---------------------+
                    |
           +---------------------+
           | service-enum.sh     |
           +---------------------+
                    |
           +---------------------+
           | subfinder-wrapper.py|
           +---------------------+
                    |
           +---------------------+
           | screenshot-taker.py |
           +---------------------+
                    |
           +---------------------+
           |  outputs/<fecha>/   |
           +---------------------+
```

## Recomendaciones de seguridad y ética

- **¡Solo utilizar en sistemas y redes autorizadas!** La ejecución de herramientas de reconocimiento sin permiso es ilegal y antiético.
- Mantén registros de autorización para pruebas.
- Aísla y etiqueta los datos sensibles.
- Revisa y limpia los outputs antes de compartir fuera del entorno autorizado.
- Actualiza regularmente las dependencias para evitar vulnerabilidades.
- No ejecutes scripts con privilegios innecesarios.

---