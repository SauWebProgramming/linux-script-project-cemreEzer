[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/g9rN3dhc)
#Linux Script Projesi 
## İçerik 
- monitor.sh: Sistem bilgilerini toplayan script 
- screenshot.png: Çalıştığına dair ekran görüntüsü

## Kurulum 
'''bash
sudo cp monitor.sh /usr/local/bin/monitor.sh
sudo chmod +x /usr/local/bin/monitor.sh
# Çalıştırma 
sudo /usr/local/bin/monitor.sh
#Cron
sudo crontab -e 
#saat güncelleme için kullanılan satır:
* * * * * /usr/local/bin/monitor.sh
