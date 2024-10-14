while IFS='' read -r line || [[ -n "$line" ]]; do
  brew install "$line"
done <"./brew.txt"
