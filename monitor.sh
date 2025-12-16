#!/bin/bash
set -e

TARIH="$(date)"
CPU_LOAD="$(uptime | awk -F'load average:' '{print $2}' | xargs)"

RAM_TOTAL="$(free -m | awk '/Mem:/ {print $2}')"
RAM_USED="$(free -m | awk '/Mem:/ {print $3}')"

DISK_LINE="$(df -h / | awk 'NR==2 {print $0}')"
DISK_SIZE="$(echo "$DISK_LINE" | awk '{print $2}')"
DISK_USED="$(echo "$DISK_LINE" | awk '{print $3}')"
DISK_AVAIL="$(echo "$DISK_LINE" | awk '{print $4}')"
DISK_PCT="$(echo "$DISK_LINE" | awk '{print $5}')"

USER_COUNT="$(who | wc -l)"

cat > /var/www/html/index.html <<HTML
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="refresh" content="60">
  <title>Sunucu Durum Paneli</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    .card { border: 1px solid #ddd; border-radius: 10px; padding: 16px; margin: 12px 0; }
    h1 { margin-bottom: 6px; }
    .muted { color: #666; }
    code { background:#f6f6f6; padding:2px 6px; border-radius:6px; }
  </style>
</head>
<body>
  <h1>Sunucu Durum Paneli</h1>
  <p class="muted">Rapor Saati: <b>$TARIH</b></p>

  <div class="card">
    <h2>CPU</h2>
    <p>Load Average: <code>$CPU_LOAD</code></p>
  </div>

  <div class="card">
    <h2>RAM</h2>
    <p>Toplam: <code>${RAM_TOTAL} MB</code> | Kullanılan: <code>${RAM_USED} MB</code></p>
  </div>

  <div class="card">
    <h2>Disk (/)</h2>
    <p>Toplam: <code>$DISK_SIZE</code> | Kullanılan: <code>$DISK_USED</code> | Boş: <code>$DISK_AVAIL</code> | Doluluk: <code>$DISK_PCT</code></p>
  </div>

  <div class="card">
    <h2>Aktif Kullanıcılar</h2>
    <p>Bağlı kullanıcı sayısı: <code>$USER_COUNT</code></p>
  </div>

  <p class="muted">Bu sayfa her 60 saniyede bir otomatik yenilenir.</p>
</body>
</html>
HTML
