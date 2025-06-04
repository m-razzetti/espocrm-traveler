# Traveler EspoCRM (Dockerized)

This is a production-ready Docker setup for EspoCRM, customized for a travel agent CRM called **Traveler**.

## ✅ Features

- Automatically downloads latest EspoCRM from GitHub
- Apache configured with `mod_rewrite` and production best practices
- `cron` service enabled for scheduled jobs
- Editors installed: `nano`, `joe`
- MariaDB container included

## 🚀 Quick Start

### One-liner install (on your Raspberry Pi):

```bash
git clone https://github.com/m-razzetti/espocrm-traveler.git
cd espocrm-traveler
sudo docker compose build --no-cache
sudo docker compose up -d
```

### Access EspoCRM:

Open in browser:
```
http://<your-raspberry-pi-ip>:8080
```

Use these database credentials in the installer:

| Field         | Value     |
|---------------|-----------|
| DB Host       | db        |
| DB Name       | espocrm   |
| DB User       | espocrm   |
| DB Password   | espocrm   |

## 🔁 Scheduled Jobs

Already installed:

```
* * * * * cd /var/www/html; /usr/local/bin/php -f cron.php > /dev/null 2>&1
```

## 🛠 Services

- `traveler_crm`: EspoCRM
- `traveler_db`: MariaDB 10.5

## 📂 Volumes

- `db_data`: persistent MariaDB storage

---

Built by [m-razzetti](https://github.com/m-razzetti)
