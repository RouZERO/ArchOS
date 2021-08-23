ENTRAR UEFI

systemctl reboot --firmware-setup

ADD STEAM ATIVAR GAMEMODE

gamemoderun %command%

Feedback ao digitar senha

sudo gedit /etc/sudoers

Passo 3. Procure a linha que contém o valor Defaults env_reset e adicione outra linha abaixo dela, com o conteúdo Defaults pwfeedback;



temas flatpak /var/lib/flatpak/runtime/

flatpak install flathub org.gnome.eog


FLATPAK TEMAS

If you have any experience with Flatpak, you know that it has support for GTK3 themes. If your current system theme matches one that's in the Flathub repository (flatpak search themes) then Flatpak will automatically installthe corresponding theme and your applications will look exactly as the rest of your standard Mint apps. However, for those of us that use custom themes - I am currently using Vertex-Maia - this becomes a problem. I will explain how to easily add your custom themes to any of your Flatpak apps.

Flatpak themes are installed in the runtime platform associated with the application. In this example, I installed Okular, which uses the KDE environment. To find out the name of the installed runtime, you will do this:

Code: Select all

$ flatpak info org.kde.okular | grep Runtime
Runtime: org.kde.Platform/x86_64/5.11

Next, you will need to know if the runtime was installed for everyone (system) or just for you (user):

Code: Select all

$ flatpak list | grep org.kde.Platform/x86_64/5.11
org.kde.Platform/x86_64/5.11	user,runtime
org.kde.Platform/x86_64/5.11	system,runtime

Now that we know the name of the installed runtime, we can now find the location of the themes folder:
User: ~/.local/share/flatpak/runtime/org.kde.Platform/x86_64/5.11/active/files/share/themes
System: /var/lib/flatpak/runtime/org.kde.Platform/x86_64/5.11/active/files/share/themes

To install one of your themes, just copy it into the proper folder and restart the app (don't use symlinks - I tried this and my theme was ignored).
NOTE: this is a temporary fix to hold me over until I figure out how to build Flatpak themes from source, but it definitely works. I've tested it with Evolution 3.30, GIMP 2.10, LibreOffice 6.1.4.2, and Okular. The one thing you'll need to pay attention to is if one of your apps switches to a newer runtime during an upgrade; this seems to affect Gnome-based apps the most.

Feel free to PM me if you have any questions.




WINE 



sudo pacman -Sy
sudo pacman -S wine-staging winetricks
sudo pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox



STEAM 

cd .steam/steam/steamapps/
mv downloading /var/tmp/
ln -s /var/tmp/downloading
