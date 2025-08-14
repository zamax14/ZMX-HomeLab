# 🏠 Homelab Docker Compose

Un setup completo de homelab usando Docker Compose con múltiples servicios para gestión, monitoreo y productividad.

## � Instalación Rápida

```bash
# Clonar el repositorio
git clone https://github.com/zamax14/ZMX-HomeLab.git
cd ZMX-HomeLab

# Configurar variables de entorno
cp .env.example .env
nano .env  # Editar con tus configuraciones

# Configurar permisos de Jenkins
sudo chown -R 1000:1000 services/jenkins/home/

# Iniciar servicios
docker compose up -d
```

## �🚀 Servicios Incluidos

| Servicio                | Puerto(s)           | Descripción                        |
|-------------------------|---------------------|------------------------------------|
| **Nginx Proxy Manager** | 81                  | Reverse proxy con SSL automático   |
| **Nginx Proxy (HTTP)**  | 8080                | Proxy HTTP                         |
| **Nginx Proxy (HTTPS)** | 8443                | Proxy HTTPS                        |
| **Homer**               | 8085                | Dashboard principal                |
| **Portainer**           | 9443                | Gestión de contenedores            |
| **Pi-hole**             | 1053, 8000          | DNS bloqueador de publicidad       |
| **Home Assistant**      | 8123                | Automatización del hogar           |
| **Nextcloud**           | 8082 (proxy)        | Storage y colaboración             |
| **Vaultwarden**         | 8083 (proxy)        | Gestor de contraseñas              |
| **Wiki.js**             | 8084 (proxy)        | Wiki personal/empresarial          |
| **n8n**                 | 5678 (proxy)        | Automatización de flujos           |
| **Jenkins**             | 8086 (proxy)        | CI/CD                              |
| **NetData**             | 19999               | Monitoreo de sistema               |
| **Postgres**            | 5432                | Base de datos                      |
| **Adminer**             | 8081 (proxy)        | Interfaz de BD                     |

## 🛠️ Instalación Detallada

### 1. Requisitos previos

- **Docker**: Instalar Docker siguiendo la [documentación oficial](https://docs.docker.com/engine/install/)
- **Docker Compose**: Incluido con Docker Desktop o instalar por separado

### 2. Clonar y configurar el proyecto

```bash
# Clonar el repositorio
git clone https://github.com/zamax14/ZMX-HomeLab.git
cd ZMX-HomeLab
```

### 3. Configurar variables de entorno

```bash
# Copiar el archivo de ejemplo
cp .env.example .env

# Editar con tus configuraciones
nano .env
```

**⚠️ IMPORTANTE**: Cambiar todas las contraseñas por defecto antes de iniciar los servicios.

Generar tokens seguros:
```bash
# Para VAULTWARDEN_ADMIN_TOKEN:
openssl rand -base64 32

# Para N8N_ENCRYPTION_KEY:
openssl rand -hex 16
```

Configurar en `.env`:
- `POSTGRES_PASSWORD`: Password para PostgreSQL
- `PIHOLE_PASSWORD`: Password para Pi-hole admin
- `VAULTWARDEN_ADMIN_TOKEN`: Token generado arriba
- `NEXTCLOUD_ADMIN_PASSWORD`: Password para Nextcloud
- `N8N_ENCRYPTION_KEY`: Clave generada arriba
- `LOCAL_IP`: IP real de tu servidor

### 4. Configurar Homer Dashboard (opcional)

Si quieres personalizar el dashboard, edita el archivo de configuración:

```bash
# Editar configuración de Homer
nano services/homer/config/config.yml
```

Ajusta las IPs y servicios según tu configuración en el archivo `config.yml`.

### 5. Configurar permisos de Jenkins

```bash
# Configurar permisos de Jenkins
sudo chown -R 1000:1000 services/jenkins/home/
```

### 6. Iniciar servicios

```bash
# Iniciar todos los servicios
docker compose up -d

# Ver logs en tiempo real
docker compose logs -f

# Ver estado de servicios
docker compose ps
```

## 🌐 Acceso a Servicios

Una vez iniciado, accede a los servicios desde cualquier dispositivo en tu red local:

- **Dashboard Homer**: http://YOUR_SERVER_IP:8085
- **Nginx Proxy Manager**: http://YOUR_SERVER_IP:81
- **Nginx Proxy (HTTP)**: http://YOUR_SERVER_IP:8080
- **Nginx Proxy (HTTPS)**: https://YOUR_SERVER_IP:8443
- **Portainer**: https://YOUR_SERVER_IP:9443  
- **Home Assistant**: http://YOUR_SERVER_IP:8123

Los demás servicios estarán disponibles a través de Nginx Proxy Manager.

## ⚙️ Configuración Post-Instalación

### Nginx Proxy Manager
1. Ve a `http://YOUR_SERVER_IP:81`
2. Login inicial:
   - Email: `admin@example.com`
   - Password: `changeme`
3. Configura proxy hosts para cada servicio interno

### Pi-hole  
1. Encuentra la IP del contenedor: `docker inspect pihole | grep IPAddress`
2. Ve a `http://IP_DEL_CONTENEDOR/admin`
3. Password: el definido en `.env`

### Jenkins
```bash
# Obtener password inicial
docker compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### Home Assistant
1. Ve a `http://YOUR_SERVER_IP:8123`
2. Sigue el asistente de configuración

## 🔧 Comandos Útiles

```bash
# Parar todos los servicios
docker compose down

# Actualizar imágenes
docker compose pull

# Recrear con nuevas imágenes
docker compose up -d --force-recreate

# Ver logs de un servicio específico
docker compose logs -f [nombre_servicio]

# Backup de base de datos
docker compose exec postgres pg_dumpall -U zamax > backup-$(date +%Y%m%d).sql

# Backup completo
tar -czf homelab-backup-$(date +%Y%m%d).tar.gz services/
```

## 🛡️ Seguridad

- ✅ Variables sensibles en `.env`
- ⚠️ **IMPORTANTE**: Cambiar todas las contraseñas por defecto en `.env`
- ⚠️ Configurar SSL con Nginx Proxy Manager para servicios públicos
- ⚠️ Configurar firewall según necesidades

## 🐛 Solución de Problemas

### Error de permisos en Jenkins
```bash
sudo chown -R 1000:1000 services/jenkins/home/
```

### Postgres no inicia
```bash
# Verificar permisos
ls -la services/postgres/
# Ver logs
docker compose logs postgres
```

### No se puede acceder a servicios
```bash
# Verificar estado
docker compose ps
# Verificar red
docker network ls
```

---

**📝 Nota**: Este setup está optimizado para uso en red local. Para exposición a internet, configurar adicionalmente firewall, VPN y certificados SSL apropiados.

**🔗 Repositorio**: https://github.com/zamax14/ZMX-HomeLab
