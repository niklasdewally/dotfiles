# Dotfiles

Managed by YADM

# Installation

## Host
```
curl -fLo /cs/home/nd60/usr/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /cs/home/nd60/usr/bin/yadm
alias yadm="yadm -Y /cs/home/nd60/.yadm"
yadm clone ssh://git@github.com/niklasdewally/dotfiles --bootstrap
```

## Personal

```
sudo curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && sudo chmod a+x /usr/local/bin/yadm
yadm clone ssh://git@github.com/niklasdewally/dotfiles
```
