# Dewian-desktop 

### Base on dewian:latest

Debian-desktop image dengan repositori lokal #kambing.ui.ac.id dan desktop xfce4. Use VNC Viewer (or alternate) to access it.

### Run container

```
docker run -it --rm -p 5901:5901 -e USER=xuser dewian-desktop bash -c "vncserver :1 -geometry 1280x700 -depth 24 && tail -F ~/.vnc/*.log"
```

### VNC Password

```
debian
```

### Repositori

  - deb http://kambing.ui.ac.id/debian/ jessie main contrib non-free
  - deb http://kambing.ui.ac.id/debian/ jessie-updates main contrib non-free
  - deb http://kambing.ui.ac.id/debian-security/ jessie/updates main contrib non-free

