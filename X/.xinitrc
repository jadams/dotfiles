xautolock -time 5 -locker "betterlockscreen -l" -notify 120 -notifier "xset dpms force off" &
xbindkeys
xinput set-prop bcm5974 "libinput Tapping Enabled" 1
redshift -l 21.363106:-158.082206 &
betterlockscreen -w dim
dropbox-cli start
exec i3
