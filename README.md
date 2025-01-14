```bash
cd /Users/john/Developer

/opt/homebrew/bin/stow \
  --simulate
  --verbose
  --target=/Users/john
  --dir=/Users/john/Developer/Dotfiles
  dotfiles
```

(and then run without --simulate)
