# is bash the best language for this? probably not. too bad!

if [ -d ~/stowfiles ]; then
else
  echo "repo was cloned incorrectly; parent this repo to home directory."
  return 1
fi

stowed=("bat", "fish", "kitty", "nvim", "starship")
not_stowed=("stow", "lsd")
prerequisites_installed=true

# check if all items in stowed are installed
for item in stowed
do
  if ! command -v "$item" >/dev/null 2>&1; then
    echo "error: {$item} is not installed"
    prerequisites_installed=false
  fi
done

# check if all items in not_stowed are installed
for item in not_stowed
do
  if ! command -v "$item" >/dev/null 2>&1; then
    echo "error: {$item} is not installed"
    prerequisites_installed=false
  fi
done

# go figure
if ! $prerequisites_installed; then
  return 1
fi

echo "stowing items..."
echo "---"
for item in stowed
do
  stow "$item"
  echo "{$item} stowed"
done

echo "---"
echo "Program done!"
# probably don't need the below line, but just in case.
return 0
