#!/run/current-system/sw/bin/zsh

# Set wallpaper folder
wallpaper_folder="$HOME/Wallpapers"

# Find all image files
wallpapers=($wallpaper_folder/*.{jpg,jpeg,png,webp})

# Get current wallpaper (for KDE, Sway, or custom setups)
current_wallpaper=$(cat ~/.current_wallpaper 2>/dev/null)

# Pick a random wallpaper that is NOT the current one
new_wallpaper=""
while [[ -z "$new_wallpaper" || "$new_wallpaper" == "$current_wallpaper" ]]; do
    new_wallpaper=${wallpapers[RANDOM % ${#wallpapers[@]} + 1]}
done

# Save current wallpaper to a file
echo "$new_wallpaper" > ~/.current_wallpaper

plasma-apply-wallpaperimage "$new_wallpaper"

echo "Wallpaper changed to: $new_wallpaper"
