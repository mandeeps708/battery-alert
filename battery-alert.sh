#/bin/sh
let battery=`upower -i $(upower -e | grep 'BAT') | grep -E "percentage"| awk '{ print $2 }'|cut -c3 --complement`
#echo $battery
stat=`acpi -b | awk '{print $3}'| rev | cut -c 2- | rev`
echo $stat
if [ $battery -gt 80 ] && [ "$stat" = "Charging" ]
then
    play -n -c1 synth sin %-12 sin %-9 sin %-5 sin %-2 fade q 0.1 1 0.1
elif [ $battery -le 80 ] && [ "$stat" = "Discharging" ]
then
    play -n -c1 synth sin %-12 sin %-9 sin %-5 sin %-2 fade q 0.1 1 0.1
    #zenity --info --title="charge it" --text="Plug-in your charger!"&
else
    echo "Just chill man! your battery is still $battery%";
fi
