# build -> docker -t dewian-desktop .
# run   -> docker run -it --rm -p 5901:5901 -e USER=xuser dewian-desktop bash -c "vncserver :1 -geometry 1280x700 -depth 24 && tail -F ~/.vnc/*.log"
# vnc-password:debian

FROM iruwl/dewian:latest
MAINTAINER Khairul Anwar <irul.sylva@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y lightdm xfce4 xfce4-terminal xfce4-goodies menu tightvncserver
RUN rm -rf /var/lib/apt/lists/*

# Enable bash tab-complete
#RUN touch /etc/X11/Xsession.d/00my-startup && \
#  echo "xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<'Super'>'Tab -r" >> /etc/X11/Xsession.d/00my-startup && \
#  chmod +x /etc/X11/Xsession.d/00my-startup

ADD run.sh /root/run.sh
CMD ["./run.sh"]

# -------------------------------------------------------------------------------------------------------------------------------------------------

# Add normal user
RUN \
  addgroup --system xuser && \
  adduser \
    --home /home/xuser \
    --disabled-password \
    --shell /bin/bash \
    --gecos "Mr. X" \
    --ingroup xuser \
    --quiet \
    xuser && \
  echo 'xuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add user to sudo group (with no password)
#RUN adduser xuser sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set user passwd
#RUN echo 'xuser:pwd123' | chpasswd

# Define working directory
WORKDIR /home/xuser

# Activate xuser
USER xuser

# Define default command.
CMD ["/bin/bash"]

RUN touch ~/tab.sh && \
  echo "#Enable bash tab-complete\nxfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<'Super'>'Tab -r" >> ~/tab.sh && \
  chmod +x ~/tab.sh
RUN touch ~/.Xresources && touch ~/.Xauthority
RUN mkdir ~/.vnc && echo "debian" | vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd

# Expose ports
EXPOSE 5901
