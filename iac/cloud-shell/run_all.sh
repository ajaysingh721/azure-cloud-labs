# Run all scripts in the current directory
for script in $(ls *.sh); do
  echo "Running $script"

  # Run the script with try/catch
    bash $script
done

